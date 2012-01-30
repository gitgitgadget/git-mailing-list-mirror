From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 20:10:01 +0200
Message-ID: <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
	<1327944197-6379-5-git-send-email-felipec@infradead.org>
	<20120130175324.GH10618@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:10:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrvgA-0003sr-29
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab2A3SKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 13:10:04 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:40202 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752351Ab2A3SKC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:10:02 -0500
Received: by lagu2 with SMTP id u2so2370575lag.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 10:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7RvenEUmOYTjDFG1Od7FFBhF+nWhp4NECUTWmlPyf0w=;
        b=kwILXmnsbwUtVgjhV9IoTcogFG0z8B2V00uSf38dlVyJjwgKAkSxxJ0Z0DlQ7mtdX8
         hFVJ1BNdZbPaRIwxqJhkvG0Yg8ZKUdXmpLvTNxV5FcBewohCODNSjppsxt4Bz/+ohWDO
         jN9SEYNOXQZe008f4LcTa3oBaexsysaa3HP9M=
Received: by 10.112.48.65 with SMTP id j1mr4717394lbn.76.1327947001331; Mon,
 30 Jan 2012 10:10:01 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Mon, 30 Jan 2012 10:10:01 -0800 (PST)
In-Reply-To: <20120130175324.GH10618@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189385>

On Mon, Jan 30, 2012 at 7:53 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -657,7 +657,8 @@ __git_merge_strategies=3D
>> =C2=A0# is needed.
>> =C2=A0__git_compute_merge_strategies ()
>> =C2=A0{
>> - =C2=A0 =C2=A0 : ${__git_merge_strategies:=3D$(__git_list_merge_str=
ategies)}
>> + =C2=A0 =C2=A0 test "$__git_merge_strategies" && return
>> + =C2=A0 =C2=A0 __git_merge_strategies=3D$(__git_list_merge_strategi=
es 2> /dev/null)
>
> Why the new redirect?

It's not new, it was in the original code that your change to the ':'
stuff (eaa4e6e) replaced.

And the reason is explained right above, in the comment:

# 'git merge -s help' (and thus detection of the merge strategy
# list) fails, unfortunately, if run outside of any git working
# tree.  __git_merge_strategies is set to the empty string in
# that case, and the detection will be repeated the next time it
# is needed.

The commands might fail, that's why '2> /dev/null' was used before,
and ':' is used right now.

> If I add debugging output to __git_list_merge_strategies that writes =
to stderr, I want to see it.

Well, you wouldn't see it right now, so that out of scope of this patch=
=2E

> Why the 'test "$foo"' form instead of [[ -n which is more common in
> this completion script? =C2=A0Why use "return" instead of
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0[[ -n $var ]] || var=3D$(...)
>
> which feels a little simpler?

Because this is _huge_:

[[ "$__git_merge_strategies" ]] ||
__git_merge_strategies=3D$(__git_list_merge_strategies 2> /dev/null)

And IMO harder to read. But you are correct that most of the code uses
[[]], which I think is a shame. But I guess people want to keep using
that.

So, how about?

[[ "$__git_merge_strategies" ]] && return
__git_merge_strategies=3D$(__git_list_merge_strategies 2> /dev/null)

--=20
=46elipe Contreras
