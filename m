From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's the difference between `git show branch:file | diff -u -
 file` vs `git diff branch file`?
Date: Mon, 29 Aug 2011 23:09:05 +0700
Message-ID: <CACsJy8Dar5i3Fn+rhOq78vdsqRL4D+RNUc5G64BM-6DvKC=L5w@mail.gmail.com>
References: <loom.20110823T091132-107@post.gmane.org> <CACsJy8DMqjMfb5wVMnsrZhP8yv2rF1wyQ6LM6b-PVcYY1SXkcQ@mail.gmail.com>
 <loom.20110829T155805-331@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:09:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4P8-0000eg-NT
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686Ab1H2QJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 12:09:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36531 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793Ab1H2QJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 12:09:36 -0400
Received: by bke11 with SMTP id 11so4284108bke.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 09:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lpaFn4DayLFCw5DoEEPKFD4V0b2eOuUhtlYh2ecBtxU=;
        b=W+0S+5lktaJ70JV8LFUAKKbRZBjBDdkKvWPB6w9EyeE9G/a9/ellBlRt2+hqJYO+c2
         uVVBt0vngwR8L9tBqiXGsdIsF2VojJ+t/Pg+4YQVwDOrV3ufu+uz5FklrobwOSsxTEb8
         Yk4i1cnxPxd/uxnWiwqw02F1pfTJ+eV/JjkO8=
Received: by 10.204.135.18 with SMTP id l18mr2489140bkt.341.1314634175134;
 Mon, 29 Aug 2011 09:09:35 -0700 (PDT)
Received: by 10.204.7.138 with HTTP; Mon, 29 Aug 2011 09:09:05 -0700 (PDT)
In-Reply-To: <loom.20110829T155805-331@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180314>

On Mon, Aug 29, 2011 at 9:48 PM, Marat Radchenko <marat@slonopotamus.or=
g> wrote:
> Nguyen Thai Ngoc Duy <pclouds <at> gmail.com> writes:
>> =C2=A0- is "file" above at top repo, or is it actually very/deep/pat=
h/to/a/file?
> 3 levels deep. Most parent dir (one after repo root) contains 20k fil=
es.
>
>> =C2=A0- how many entries in the tree that contain "file"?
> Sorry, didn't understand this.

You have already answered it. I was asking the size of parent dir, but
phrased poorly.

>> =C2=A0- how is "git ls-files | wc -l"?
> $ time git ls-files | wc -l
> 603137
>
> real =C2=A0 =C2=A00m0.417s
> user =C2=A0 =C2=A00m0.440s
> sys =C2=A0 =C2=A0 0m0.060s
>
>> =C2=A0- how about "time git diff branch another-branch -- file >/dev=
/null"?
>> That'd remove unpack-trees code.
> Pretty fast:
>
> git diff HEAD branch -- file > /dev/null
>
> real =C2=A0 =C2=A00m0.276s
> user =C2=A0 =C2=A00m0.240s
> sys =C2=A0 =C2=A0 0m0.030s

That may explain it. "git diff <ref>" walks through the index, unpacks
tree objects along the way, matches up entries with the same path from
the branch, the index then feeds matching entries to diff function. If
tree cutting is not done efficiently, it could very well walk through
every entry in the index (~600k entries in your case), unpacking all
tree objects along the way.

And it looks like to me that diff_cache() in diff-lib.c, responsible
for this case, does not do any prefix trimming. traverse_trees() also
does not seem to do "never_interesting" optimization like in
tree_interesting(), so if the traversed tree is big (~20k as you told
me), it will take some time, even though you are only interested in a
single entry.

> So the only troubled variant is `git diff branch -- file`.

No, I suspect "git diff --cached" would be also slow. "git merge"
would be definitely slow. But we can hardly improve these cases
because the commands are usually called tree-wide, no path limiting.

If you only work on a small subset of files, there's some (unfinished)
code in narrow clone implementation that cuts down index size, which
may speed up in big-index repositories like yours. Could be a good
reason for me (or someone) to extract that part and get it in before
full narrow clone is implemented.
--=20
Duy
