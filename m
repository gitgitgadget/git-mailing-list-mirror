From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Sun, 02 Sep 2012 18:47:13 -0700
Message-ID: <7vipbvg9ni.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <7vvcfwf937.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 03:47:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Ll7-00016x-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 03:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627Ab2ICBrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 21:47:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59144 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755479Ab2ICBrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 21:47:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8516C8E70;
	Sun,  2 Sep 2012 21:47:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bWjioWaWZ4ud/lGgfDnSuRNxv98=; b=DhlQWN
	eoolcaUGoLaRXY8LFM4YgjADzFjtm40t8XLx6hTzx4PbDTS/ezBf8+isqj9BAQu9
	WSTA6Mi049Z5hWDDcMjsN0eeB5jUDSp5OVrMBlMXRHK0S6Moz+B/mNmnayY0Tw0k
	FPjkvdsI81g+XYww5yvnBpyTgEUWdbWo2hHSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZyaskO86xzuEEdMVUwFhOi/sQADvMIQD
	3yhxvQyvow1RZZiL2glZQhhxz1su5HN/lX/eCfMC/BDxP0hDpsji1XTKpSbK9T+/
	4OhmMqdZ7Jc3ft5s1bJKCqQV5GseVVVGsWy2Ansu24cJ4RytliX3aFPubrWGgWKT
	N3mO0L44y9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73ACC8E6F;
	Sun,  2 Sep 2012 21:47:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB4458E6E; Sun,  2 Sep 2012
 21:47:14 -0400 (EDT)
In-Reply-To: <7vvcfwf937.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 02 Sep 2012 13:41:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4953800A-F569-11E1-9D03-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204680>

Junio C Hamano <gitster@pobox.com> writes:

> Let's step back a bit and think what this command is about.  What is
> the reason why the user wants to run "check-ignore $path" in the
> first place?  I think there are two (or three, depending on how you
> count).
>
>  (1) You have one (or more) paths at hand.  You want to know if it
>      is (or some of them are) ignored, but you do not particularly
>      care how they are ignored.  Think of implementing your own "git
>      add" as a script.
>
>  (2) You have one or more paths that are ignored but do not want
>      them to be, and want to find out why they are.  

A reason related to (2) is to find out why the paths you want to be
excluded are included, so that you can fix it by disabling an entry
in .gitignore that covers too widely, or by adding a new entry to
override it.

For that to work, the "-v" mode needs to show all paths that were
given from the command line (or --stdin), to explain why each of
them is ignored or not ignored.  Hence, in addition:

> For the latter, you are debugging the set of exclude sources and
> want to learn where the decision to exclude it comes from.  For that
> kind of use, it would be more useful if the output mimicked error
> messages from the compilers and output from "grep -n" to show the
> source, e.g.
>
> 	.gitignore:13:/git-am	git-am

we would need an entry that shows !<include pattern> in the output.

A path that does not match any pattern anywhere in the exclude files
is taken as included---I am not sure what is the best way to explain
the reason why they are included.  If we are going to show the entry
that finally matched (either with negative or positive pattern) and
decided the "fate" as the explanation for both excluded and included
paths, perhaps not showing an entry for such a "never matched" path
might be a good enough explanation.
