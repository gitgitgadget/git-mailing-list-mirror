From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Wed, 15 Apr 2015 13:52:48 -0700
Message-ID: <xmqqiocxjeqn.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 22:53:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiUIr-00033F-34
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 22:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbDOUww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 16:52:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54577 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751536AbbDOUwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 16:52:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1660649CFB;
	Wed, 15 Apr 2015 16:52:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S1mMuLvEpSPJs/sf9RYA4GcpBq4=; b=Dyel5w
	v1CUe7R3BVcNhA/7a0EU/WKa8lZjco7o2CmOt0MjwvDNBBEF9N/cyCwsO2CgOyRH
	H+WYjSceQFntKVRp/Qf0qdtJ6noNYiDO4/NersY65bd0OAsSzt2LykzcX9ohNt37
	qCPEkPsIexMRzlK//rxzPIoDorvnTSirjoTdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fEfUqtvO4z7+ypR4oWg1rrIBpq/ywgSi
	utdct++yv6Ydh476oLwCrGNOo+CYavfjqi8hqJwV30uMeJu6ulMBLosuGCnefgd9
	FvGf31BgH3w1WRnNC+ldngCTm2ZT9ZHYzxJXlRMlCvBPmKSAmQa/tEPCuu9kgn/w
	tO1Ng2oiqlw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EE4949CFA;
	Wed, 15 Apr 2015 16:52:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B88C49CF9;
	Wed, 15 Apr 2015 16:52:49 -0400 (EDT)
In-Reply-To: <xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Apr 2015 13:20:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 606EF0CE-E3B1-11E4-85BE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267239>

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
> ...
>> -	if (argc != 3 && argc != 2)
>> +	if (argc < 2 || argc > 4)
>>  		usage_with_options(cat_file_usage, options);
>
> Hmm, why this change?
>
> By allowing 4 args blindly like this, you will let something like
> these to pass:
>
>     $ git cat-file --textconv -t HEAD
>     commit
>     $ git cat-file -p -t HEAD
>     commit
>     $ git cat-file -s -t HEAD
>     commit
>     $ git cat-file -t -s HEAD
>     879
>
> It is fine if you are declaring that the last one wins when these
> mutually-exclusive options are given. "git cat-file -e -s -t HEAD"
> should also say "commit" if that is what you are doing, but instead
> the code with this patch complains, which is bad.
>
> It also is fine and is more in line with the spirit of the original
> code if you keep the rule tight and only one of these mutually
> exclusive options is allowed.
>
> In either case, this check needs to be rethought.

I wonder if we want to do something like this as a preliminary step
before your [PATCH 2/4].  Everything after the parse_options() call
seems to protect against leftover argc depending on what they need
already, so the only thing existing "we take only 2 or 3 args" check
is doing is to protect against giving more than one command mode
options, I think.  And OPT_CMDMODE() should do a much better job at
that that kind of thing, by giving a more informative error message
e.g.

    $ git cat-file -p -e HEAD
    error: switch 'e': incompatible with -p

This is a tangent, but while we are in the vicinity, we may want to
rethink the help message we attach to the '-e' option.  Technically
the current message is _not_ wrong per-se, but it misses the point.
The primary thing the option does is to check the (e)xistence of the
named object, and the fact that it does so silently is merely a
detail of the operation.  The current help text omits the more
important part of what the option is.

 builtin/cat-file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1ec7190..534991d 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -372,12 +372,12 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	const struct option options[] = {
 		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
-		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
-		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
-		OPT_SET_INT('e', NULL, &opt,
+		OPT_CMDMODE('t', NULL, &opt, N_("show object type"), 't'),
+		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
+		OPT_CMDMODE('e', NULL, &opt,
 			    N_("exit with zero when there's no error"), 'e'),
-		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
-		OPT_SET_INT(0, "textconv", &opt,
+		OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
+		OPT_CMDMODE(0, "textconv", &opt,
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_BOOL( 0, "literally", &literally,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
@@ -392,9 +392,6 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
-	if (argc < 2 || argc > 4)
-		usage_with_options(cat_file_usage, options);
-
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
