From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git filter-branch should run git gc --auto
Date: Wed, 23 Jan 2008 11:22:23 -0800
Message-ID: <7vfxwoibyo.fsf@gitster.siamese.dyndns.org>
References: <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
	<20080120093436.GA10924@diana.vm.bytemark.co.uk>
	<7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
	<20080121224818.GA8872@untitled>
	<7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
	<20080122003911.GA16453@hand.yhbt.net>
	<7vtzl6vd7v.fsf@gitster.siamese.dyndns.org>
	<BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org>
	<7v1w89qmw3.fsf@gitster.siamese.dyndns.org>
	<20080123064430.GD16297@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 20:23:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHlBi-00025c-Dh
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 20:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYAWTWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbYAWTWe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 14:22:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYAWTWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 14:22:33 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D119E3CB4;
	Wed, 23 Jan 2008 14:22:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E7E3CB3;
	Wed, 23 Jan 2008 14:22:26 -0500 (EST)
In-Reply-To: <20080123064430.GD16297@glandium.org> (Mike Hommey's message of
	"Wed, 23 Jan 2008 07:44:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71565>

Mike Hommey <mh@glandium.org> writes:

> I wonder if it wouldn't be possible to have filter-branch use
> fast-import, so that it would create a pack instead of a lot of loose
> objects.

I do not think it will help.  The objects in packs fast-import
creates cannot be accessed from outside fast-import.  Not even
the rest of the core routines running inside that fast-import
process cannot access them via the usual read_sha1_file()
interface, as described in detail in a recent thread [*1*].  The
only way to make it available while you are still feeding new
data to fast-import is to explicitly tell it to finalize the
current pack by issuing a 'mark' command (and fast-import will
start writing to a new pack).

And filters need to be able to read the objects previous steps
produced to do their work.

Which means that instead of having to deal with many loose
objects, you will now face many little packs, each contains data
changed perhaps at most one commit's worth.  You would need to
"repack -a -d" to consolidate these little packs every once in a
while, and I suspect more often than you would need to repack
loose objects, as handling many packs is much more expensive
than handling many loose objects.

[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.git/70964/focus=71076
