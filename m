From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] Implement git commit as a builtin command.
Date: Fri, 21 Sep 2007 12:32:25 -0700
Message-ID: <7vwsujizli.fsf@gitster.siamese.dyndns.org>
References: <1190074008617-git-send-email-krh@redhat.com>
	<1190074014548-git-send-email-krh@redhat.com>
	<11900740142347-git-send-email-krh@redhat.com>
	<11900740153845-git-send-email-krh@redhat.com>
	<11900740154136-git-send-email-krh@redhat.com>
	<1190074016669-git-send-email-krh@redhat.com>
	<11900740163661-git-send-email-krh@redhat.com>
	<7vk5qmm8hq.fsf@gitster.siamese.dyndns.org>
	<1190395088.31494.55.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 21:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYoEw-0001yc-Gb
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 21:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761179AbXIUTcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 15:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761015AbXIUTcc
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 15:32:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887AbXIUTcb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 15:32:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F287139724;
	Fri, 21 Sep 2007 15:32:50 -0400 (EDT)
In-Reply-To: <1190395088.31494.55.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Fri, 21 Sep 2007 13:18:08 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58870>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

>> > +
>> > +	/* update the user index file */
>> > +	add_files_to_cache(fd, files, prefix);
>> > +
>> > +	if (!initial_commit) {
>> > +		tree =3D parse_tree_indirect(head_sha1);
>> > +		if (!tree)
>> > +			die("failed to unpack HEAD tree object");
>> > +		if (read_tree(tree, 0, NULL))
>> > +			die("failed to read HEAD tree object");
>> > +	}
>>=20
>> Huh?  Doesn't this read_tree() defeat the add_files_to_cache()
>> you did earlier?
>
> This is the case where we add the files on the command line
> to .git/index, but commit from a clean index file corresponding to HE=
AD
> with the files from the command line added (partial commit?).  The fi=
rst
> add_files_to_cache() updates .git/index, then we do read_tree() to bu=
ild
> a tmp index from HEAD and then we add the files again.  The tmp index=
 is
> written to a tmp index file.

Still, if you are doing read_tree() that reads into the same
in-core cache you have just prepared in the add_fiels_to_cache()
above, potentially overwriting whatever you did, doesn't it?
That was what I was puzzled about...

> ...  As for just using an in-memory
> index, I wanted to do it that way originally, but you have to write i=
t
> to disk after all for the pre-commit hook.

Ah, I completely forgot about the hook.  Ok, scratch the idea of
not using a temporary index file.  The is not much potential for
performance gain anyway.
