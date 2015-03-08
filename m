From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [GSoC/RFC] Ideas on git fetch --deepen
Date: Sun, 8 Mar 2015 16:57:34 +0800
Message-ID: <CABwkPcoWUcK2vzqUBcEcuNzizYMtP=qUiew2HmDgqtivfDXbDg@mail.gmail.com>
References: <CABwkPcoHPyid0gKjjg0NiXY4TYtCbeSJe6XK5HEDFNKR+-_tFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 08 09:58:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUX2E-0002kX-3v
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 09:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbbCHI6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 04:58:00 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37629 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbbCHI5z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Mar 2015 04:57:55 -0400
Received: by pdbnh10 with SMTP id nh10so61302998pdb.4
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=ZQqmv34+4vvWsL/NDyeKe8gAYcKI29YYy91HP8gkbK0=;
        b=iJm6IQci4onk2IrKeTtGOrTzpbUygHeWtPqBjG1DVjVy5rNVOQpAs0VX9GvnQzH5SY
         BLV8lMs3j6u1dxzImQx2+aa346g00scUlO/Pe8Ls0ie4Mt85MuDRomvEi6dXBNfpEC2g
         J5zBmcI9RAy/JTSEjwgU1E4ADIQk9n307VjLPcIdZNEeJtMFC9Z95rnahoIEXaF2au+l
         kCCYvqSDVhDGhiVaHgtg5Rgg6rKrEr+ncwmglv5AKZbkvMchD+alUQTifqm8hB46B447
         vaR0bRIWTJLMN0wY9+x3l+Bu7NsizxDn2t2AVtbYX4dAce08dIuIS7NO9NG3N4RgBjzx
         uAGQ==
X-Received: by 10.68.65.75 with SMTP id v11mr41092171pbs.10.1425805074614;
 Sun, 08 Mar 2015 00:57:54 -0800 (PST)
Received: by 10.70.78.225 with HTTP; Sun, 8 Mar 2015 00:57:34 -0800 (PST)
In-Reply-To: <CABwkPcoHPyid0gKjjg0NiXY4TYtCbeSJe6XK5HEDFNKR+-_tFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265048>

Hi, all

After digging into how "git fetch" works, I have found that my previous
understanding was too rash. I'm sorry for that.

I find that the current workflow of "git fetch --depth" is as follows:

  1. 'fetch module' calls 'git-upload-pack service' via 'transport modu=
le'
     to fetch ref with `depth`.
  2. Such call is finished by pipe I/O.
  3. git-upload-pack receives arguments such as 'depth' to fetch commit=
s,
     and send back to the caller.

Therefore, if we want to implement "--deepen" for "git fetch", we have =
to
modify the arguments protocol of git-upload-pack service by adding the
'shallow commit' hash.
Then, we can fetch `depth` commits before the 'shallow commit' in
git-upload-pack service.
Apparently, we have to output error message when the 'shallow commit' h=
ash
is not in the repository.

However, I still have a question for [1]. I am not quite following this=
:

> If you want the new history leading to the updated tip,
> you can just say:
>
>    git fetch
>
> without any --depth nor --deepen option to end up with:
>
>  (you)
>                  A---B---C---D---E---F---...---W---X---Y---Z

As far as I know, git fetch --depth would fetch new history to the
local remotes' refs.
Does it mean that we have to change the behavior of "git fetch --depth"=
?

I hope you can give me some comments or suggestions, letting me know
whether I am in the right way.

Thanks.

[1] http://article.gmane.org/gmane.comp.version-control.git/212950

2015-03-07 14:32 GMT+08:00 Dongcan Jiang <dongcan.jiang@gmail.com>:
> Hi all,
>
> My name is Dongcan Jiang. I am studying for my Master Degree at Pekin=
g
> University
> majoring in Computer Science. I have been using Git to manage my proj=
ects
> for about half a year. It's really exciting that Git has been helping=
 me make
> revision control much more convenient. Therefore, I am very intereste=
d in
> doing some works for Git in GSoC 2015.
>
> I have submitted my v2 patch on a microproject recently, and I am wai=
ting
> for comments on v2 now.
>
> In the meantime, I have been scanning ideas on the git gsoc page and
> their related mails. I find that I am interested in most of them, esp=
ecially
> "git fetch --deepen" idea.
>
> Here is my understanding about this idea.
>
> Although "deepen" and "depth" have different behavior, "deepen" can b=
e
> achieved by "depth" with some extra calculation. If we know the
> distance between "my history bottom" and "your tips", we can set the =
sum
> of "deepen" step and this distance as "depth" step. Then we can reuse
> the logics of processing "depth" to complete it.
>
> Take graph in [1] as an example.
>
>>  (upstream)
>>   ---o---o---o---A---B
>>
>>  (you)
>>                  A---B
>
> the distance of "my history bottom"(A) and "your tips"(B) is 1, then
> "git fetch --deepen=3D3" can be achieved by "git fetch --depth=3D4"
>
> However, I am a little worried about whether this idea is enough for =
a
> GSoC project. I hope you can give me some comments and suggestions.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/212950
>
> Thanks,
> Dongcan
>
> --
> =E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
> Team of Search Engine & Web Mining
> School of Electronic Engineering & Computer Science
> Peking University, Beijing, 100871, P.R.China



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
