From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Sun, 19 Aug 2012 10:23:09 -0700
Message-ID: <7v628epzia.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Shawn Pearce'" <spearce@spearce.org>, <git@vger.kernel.org>,
	<rsbecker@nexbridge.com>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Sun Aug 19 19:23:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T39E2-000312-5D
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 19:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab2HSRXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 13:23:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53978 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223Ab2HSRXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 13:23:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B94BD813D;
	Sun, 19 Aug 2012 13:23:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YF9V7nJCinNHgIjFDW9SdqDrcXQ=; b=aNMthr
	5GGog2OdaSY5AuSE2DYCHiO/8AtCHBQwqiJL1ktYNm/J7CSaN7pMjcHh6C84DmKO
	XE0u8Ig4VW+DY1ZcVPh9Fw4179m3A0xNuEIRx/XuiA0P9S5cgXiTmNLVODMLR35u
	miBX0MVI5chQfUFRpV1QY6BkZJt+EhP5Gwff0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmtPY47iuQwrt4eK7ZzBSow3oX1ycG/7
	Iwl1GZGImMVSEhlf59alXJGveb0WI2TxB14VsPqGPMNtxBU8LjSBSH8B9JEvCpVj
	NTGFEVy3jTua9WQQvZZm/8+5uIE1ro4FtP+r8jPH3mZ1JE6DAbapvFbaSZgzFUXk
	uXiFeIm+3HQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A756A813C;
	Sun, 19 Aug 2012 13:23:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0755D8132; Sun, 19 Aug 2012
 13:23:10 -0400 (EDT)
In-Reply-To: <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de> (Joachim
 Schmitz's message of "Sun, 19 Aug 2012 10:57:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CD4FBC6-EA22-11E1-B771-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203726>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Found the problem: our mkdir(dir,flags) fails with ENOENT when dir ends with
> a '/'.
> Not sure whether this us a bug on out platform or just allowed by POSIX and
> as such a wrong assumption in git though?
>
> [shortly after]
> A bit of googleing revealed that there is a GNUlib solution for this, which
> claims that at least NetBSD 1.5.2 has the same problem.
> (http://www.opensource.apple.com/source/gpatch/gpatch-2/patch/mkdir.c)
>
> And apparently this has been discussed on the git mailing list too, 2 years
> ago:
> http://lists-archives.com/git/728359-git-s-use-of-mkdir-2.html, there's a
> patch too.

Given that newer BSDs have fixed libc to accept directory name with
a trailing slash, and that we use mkdir(2) in many places, I think
the right way to do so is still what I suggested in that old thread
in the last paragraph of my message

  http://thread.gmane.org/gmane.comp.version-control.git/155812/focus=155876

That is, have compat/tandem.c and define a replacement mkdir(2) in a
way similar to how MinGW does so.

> For now I've fixed it like this:
> /usr/local/bin/diff -EBbu ./builtin/init-db.c.orig ./builtin/init-db.c
> --- ./builtin/init-db.c.orig    2012-08-19 03:55:50 -0500
> +++ ./builtin/init-db.c 2012-08-19 03:39:57 -0500
> @@ -25,7 +25,16 @@
>
>  static void safe_create_dir(const char *dir, int share)
>  {
> +#ifdef __TANDEM /* our mkdir() can't cope with a trailing '/' */
> +       char mydir[PATH_MAX];
> +
> +       strcpy(mydir,dir);
> +       if (dir[strlen(dir)-1] == '/')
> +               mydir[strlen(dir)-1] = '\0';
> +       if (mkdir(mydir, 0777) < 0) {
> +#else
>         if (mkdir(dir, 0777) < 0) {
> +#endif

Move that part inside #ifdef __TANDEM to define

	int tandem_mkdir(const char *dir, mode_t mode)
        {
		...
	}

in your new file compat/tandem.c, add

	#ifdef __TANDEM
        #define mkdir(a,b) tandem_mkdir((a), (b))
	#endif

to git-compat-util.h and then add compat/tandem.o to COMPAT_OBJS in
the top-level Makefile.

That way we do not have to keep an ugly platform specific ifdef in
the very generic codepath.

>                 if (errno != EEXIST) {
>                         perror(dir);
>                         exit(1);
>
>
>
> Bye, Jojo 
