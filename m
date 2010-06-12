From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Sat, 12 Jun 2010 00:58:32 -0500
Message-ID: <20100612055831.GA2426@burratino>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Bobby Powers <bobbypowers@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:00:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONJl8-0003uI-4s
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 07:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab0FLF6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jun 2010 01:58:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63911 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0FLF6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 01:58:41 -0400
Received: by iwn9 with SMTP id 9so1184554iwn.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=x5hg+aFZRLi0xTY/Dy9lIfLwRgeXvq4CEsk26V8D06M=;
        b=Ze+Hag2IZkApBP55dX6jkbY54QsBEvEEyX5jyYUytL+rcIayLsAJHI/d5x9aR5qyfc
         wMMLs7rMJTV+ghyBNvmiL9fNwx9BBzkP018G8fD1obEqsIxhhyJxU6Yn6Se0SvSTojN3
         3Bj+p+kqtarG/tb2iEPCxTFNIpicocd2RQsVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tqhbEFFmvOeUfFEDUWfNakaMAgNppAcUzIRdg+4SOHIV6v2llIEF3MnDKQX4DC2phf
         jtL+2fWMorxbbbMGoXhrmqNFt/7hGr3j3uaolhedloMw6wIbFAbugbsTB9c+cK/H+/iH
         WsPZ0dEG7DnpfXwIqcv3UitUVw1j9PSyj4hMg=
Received: by 10.231.120.76 with SMTP id c12mr2839412ibr.92.1276322319646;
        Fri, 11 Jun 2010 22:58:39 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm8849852ibf.19.2010.06.11.22.58.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 22:58:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148988>

Bobby Powers wrote:

> This can be useful situations where you have a batch of commits to
> cherry-pick and need to prefix each new commit message with similar
> information

Sounds reasonable.

Cc-ing Christian who is closer to an area expert.

> (such as the subversion revision, when used in conjunction
> with git-svn).

Could you give an example?  I am imagining

  git cherry-pick --prepend=3D'r3815: ' HEAD..svn/Trunk

but I haven=E2=80=99t figured out the context.

The patch itself is clean.  Two tiny nitpicks:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -64,7 +65,7 @@ static void parse_args(int argc, const char **argv)
>  		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
>  		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
>  		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy")=
,
> -		OPT_END(),
> +		OPT_STRING(0, "prepend", &prepend, "message", "string to prepend t=
o the commit message"),
>  		OPT_END(),
>  		OPT_END(),
>  	};

This adds an option to cherry-pick and revert...

[...]
> @@ -482,6 +485,9 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  		next =3D commit;
>  		next_label =3D msg.label;
>  		set_author_ident_env(msg.message);
> +		if (prepend) {
> +			strbuf_addstr(&msgbuf, prepend);
> +		}
>  		add_message_to_msg(&msgbuf, msg.message);
>  		if (no_replay) {
>  			strbuf_addstr(&msgbuf, "(cherry picked from commit ");

=2E.. and implements it only for cherry-pick (with unnecessary braces).

I would be interested to hear from those who might know whether
something generic like the applypatch-msg hook could work (which is
not to say a convenient command-line option would not be handy to have
in addition to that.)

Jonathan
