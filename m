From: Junio C Hamano <gitster@pobox.com>
Subject: Re: denyNonFastForwards & co fail outside refs/<heads,tags>
Date: Tue, 29 Mar 2011 16:59:19 -0700
Message-ID: <7vy63xo4vc.fsf@alter.siamese.dyndns.org>
References: <hbf.20110329j1zo@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Wed Mar 30 01:59:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4iox-0006TR-9b
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 01:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab1C2X7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 19:59:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51575 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab1C2X73 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 19:59:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D273059C8;
	Tue, 29 Mar 2011 20:01:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0CzcyKhnRL+dmpnwlayafZpHAek=; b=wXzNxh
	KF/u9R5LHsd+AMJy0xjbw8tCNtqqEfalmO/awym4ikdQDW6EEBIOikzqx6Qf+AAB
	V2O6rgjyHoG8AyINnRzDHOc9Xgxbi40YXWsro7XKzeWflkVBl9w3vrhbXWbYwqsX
	SQJ2vl0nNGGxwKPWPOmc+8mtRzv6YKHbtr/ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N4HSh2InVciuHj/mpwZ5n64XgV65Szhn
	v2LzVzC2Rt2GUlRvfeYBVcvY0WsCyyfkzN2y/TQb96UjxbluJuoc80Ltk1dnmI9Q
	myuDYqeWjg21XZtUI+WVdwYlpGVZO6r6ioSbPiNyvo5KlI1g1lFWLasIULV0ejFp
	MI6z6K0Q1Yw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0B5B59C3;
	Tue, 29 Mar 2011 20:01:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C5F8459BD; Tue, 29 Mar 2011
 20:01:08 -0400 (EDT)
In-Reply-To: <hbf.20110329j1zo@bombur.uio.no> (Hallvard B. Furuseth's message
 of "Tue, 29 Mar 2011 13:54:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D28532BA-5A60-11E0-BABD-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170339>

Hallvard B Furuseth <h.b.furuseth@usit.uio.no> writes:

> config options receive.<denyNonFastForward, denyDeletes> do not work in
> nonstandard ref namespaces.  I stumbled over it in refs/notes/, but the
> problem is general.  Or if it this intentional, it is the git-config(1)
> doc of these options which needs fixing.

I think it is very deliberate that denyNonFastForward does not check
anything outside local branch namespace, because there may not even be
ancestry relationship between the object a tag currently points at and the
new object the tag is trying to update (think: a tag can point at a tree
or a blob) and more importantly because pushing into refs/remotes/origin/*
namespace (which is the right way to simulate a "git fetch" from the
repository with a "git push" from outside into the repository in a
firewalled environment where you cannot initiate a connection in one
direction) should be allowed (just like "remote.*.fetch" line in
.git/config get a leading plus sign '+' by default).

I suspect that the restriction on deny_deletes was inherited by a mindless
cut & paste from the deny_non_fast_forwards codepath; I don't think of a
sane rationale to justify the limitation offhand, other than "it has been
wide open since November of 2008 and people may now be relying on that".
