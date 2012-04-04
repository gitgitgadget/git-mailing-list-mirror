From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 04 Apr 2012 11:29:21 -0700
Message-ID: <7vty0z8i66.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
 <20120404094618.GA13870@sigill.intra.peff.net>
 <7v398jbjbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 20:29:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUxW-0000qH-76
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 20:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab2DDS3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 14:29:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267Ab2DDS3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 14:29:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6542B781D;
	Wed,  4 Apr 2012 14:29:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qbO55UCYrKMMxQcKBLIduxir8xk=; b=hHhWWo
	8umjehmlV8o3dyPRJUHRQUnCqQ1mNMrhTmorbAONuoGfw6Tjig77pxErSHMeRzuq
	BGXQASTZ8VOOHocLT9PfI0GZmQ7BH+UoVJUm/6X8yeUon6oybvhAVPJfIgI7AvsE
	Dfgdz5VtlbphzMSPBVsUa8HWev4g4kN0ls2PQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q3NGAqrPFZWDBJt6WUtBk2eqOjxTgysQ
	EEVrqGtohegB/lWJoKNZe0PiG7p4ojDBWs7QD9CF4fFqUJO6whoEoemHRyzr2TyR
	goP+zGLFEIoCVt/FGOkv6QkBKfZf37HQS1Mxvg8jMsZcPsyiwLZtRSHW2jdyUXXI
	IR7qL+Y5hjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B47C781C;
	Wed,  4 Apr 2012 14:29:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB02C781A; Wed,  4 Apr 2012
 14:29:22 -0400 (EDT)
In-Reply-To: <7v398jbjbo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Apr 2012 08:36:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 199E9DB0-7E84-11E1-9F29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194718>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I do still think it would be nicer to pass the information out to the
>> caller instead of just filtering.
>
> Indeed.
>
>> So combining the two patches, we have
>> something like:
>
> Hrm.  I kind of liked the idea of doing this with a single plumbing call
> to diff-files (the entries that come from --raw will be mostly discarded
> except for the ones that are marked with "U"), though.

That is, something like this on top of your patch.

 git-add--interactive.perl |   25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 28d36f7..28c28b7 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -318,7 +318,9 @@ sub list_modified {
 		}
 	}
 
-	for (run_cmd_pipe(qw(git diff-files --numstat --summary --), @tracked)) {
+	for (run_cmd_pipe(qw(git diff-files --numstat --summary),
+			  ($note_unmerged ? ("--raw") : ()),
+			  "--", @tracked)) {
 		if (($add, $del, $file) =
 		    /^([-\d]+)	([-\d]+)	(.*)/) {
 			$file = unquote_path($file);
@@ -340,26 +342,17 @@ sub list_modified {
 			if ($bin) {
 				$data{$file}{BINARY} = 1;
 			}
-		}
-		elsif (($adddel, $file) =
-		       /^ (create|delete) mode [0-7]+ (.*)$/) {
+		} elsif (/^:[0-7]+ [0-7]+ [0-9a-f]+ [0-9a-f]+ (.)	(.*)$/) {
+			if ($1 eq 'U') {
+				$file = unquote_path($2);
+				$data{$file}{UNMERGED} = 1;
+			}
+		} elsif (($adddel, $file) = /^ (create|delete) mode [0-7]+ (.*)$/) {
 			$file = unquote_path($file);
 			$data{$file}{FILE_ADDDEL} = $adddel;
 		}
 	}
 
-	if ($note_unmerged) {
-		for (run_cmd_pipe(qw(git ls-files -u --), @ARGV)) {
-			chomp $_;
-			if (/^[0-7]+ [0-9a-f]{40} [0-3]	(.*)/) {
-				my $path = unquote_path($1);
-				if (exists($data{$path})) {
-					$data{$path}{UNMERGED} = 1;
-				}
-			}
-		}
-	}
-
 	for (sort keys %data) {
 		my $it = $data{$_};
 
