From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Tue, 21 Oct 2008 14:53:28 -0700
Message-ID: <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
References: <20081018213919.GC3107@atjola.homenet>
 <20081018224728.GD3107@atjola.homenet>
 <20081021211131.GA21606@yp-box.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 23:55:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsPC4-0001wu-4l
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 23:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326AbYJUVxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbYJUVxk
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 17:53:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbYJUVxj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 17:53:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA9778D33D;
	Tue, 21 Oct 2008 17:53:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D42998D33C; Tue, 21 Oct 2008 17:53:30 -0400 (EDT)
In-Reply-To: <20081021211131.GA21606@yp-box.dyndns.org> (Eric Wong's message
 of "Tue, 21 Oct 2008 14:12:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6A7E7BC-9FBA-11DD-97A0-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98820>

Eric Wong <normalperson@yhbt.net> writes:

>> strace revealed that git-svn url-encodes ~ while svn does not do that.
>>
>> For svn we have:
>> write(5, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
>> <S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-path>...
>>
>> While git-svn shows:
>> write(7, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
>> <S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src-path>...

This looks like an XML based request sequence to me (and svn is talking
WebDAV here, right?); it makes me wonder what exact quoting rules are used
there.  I would expect $path in <S:src-path>$path</S:src-path> to quote
a letters in it e.g. '<' as "&lt;" --- which is quite different from what
the s/// substitutions in the patch seem to be doing.

> diff --git a/git-svn.perl b/git-svn.perl
> index ef6d773..a97049a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -852,7 +852,7 @@ sub escape_uri_only {
> -		s/([^\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;
> +		s/([^~\w.%+-]|%(?![a-fA-F0-9]{2}))/sprintf("%%%02X",ord($1))/eg;

Admittedly I do not know git-svn (nor Perl svn bindings it uses), and I
suspect that some of the XML-level escaping is done in the libsvn side,
but it would be nice if somebody can at least verify that the code after
the patch works with repositories with funny characters in pathnames
(perhaps list all the printables including "<&>?*!@.+-%^").  Even nicer
would be a log message that says "the resulting code covers all cases
because it follows _that_ spec to escape _all_ problematic letters",
pointing at some in svn (or libsvn-perl) resource.

The patch may make a path with '~' work, but it (neither in the patch text
nor in the commit log message) does not have much to give readers enough
confidence that the code after the patch is the _final_ one, as opposed to
being just a band-aid for a single symptom that happened to have been
discovered this time.
