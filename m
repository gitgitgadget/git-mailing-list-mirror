From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] fast-export: Introduce --inline-blobs
Date: Wed, 19 Jan 2011 11:50:36 -0800
Message-ID: <7vtyh4smer.fsf@alter.siamese.dyndns.org>
References: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
 <1295415899-1192-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:51:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pfe3U-0002OQ-Ke
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1ASTuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:50:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab1ASTuv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:50:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ED0D14E83;
	Wed, 19 Jan 2011 14:51:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKOWFGOJOYPceE81ueRbY76WG9o=; b=DS67vh
	JLbzRXrKW2tt2TilStVTonksZ6ijs/beDSEduz56dgSv/alr8d71935yER9O7EZM
	SktFqB+FgIIkHOlcyTV5DzwNVyr9226UY3gmfggZyYf8H6oyFJDQ7Dpw1jDF+oYl
	/PHiNXgefUkPLGsJ8Lv9pF6qUQaJ23eSiZ3f0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hr5SdZjOQ+JSUbd+lIj/ydTRBrYr1EcV
	5u1hdv4pv8TzWDmlnq7Ev7wN4NoQOFBY15ZljRB4hOb3xq3JHTilWncQldZLiWnH
	A/hnyU1Uo/x2zZebV4ef2/v/uW/JuQk/AEt6iSVkuAK3Gqnncll5+KCvNy3zQArU
	Ao21gGMXVZM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B34C4E82;
	Wed, 19 Jan 2011 14:51:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 14C604E7E; Wed, 19 Jan 2011
 14:51:23 -0500 (EST)
In-Reply-To: <1295415899-1192-5-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed\, 19 Jan 2011 11\:14\:58 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 829EB2A8-2405-11E0-8C3D-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165289>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Introduce a new command-line option --inline-blobs that always inlines
> blobs instead of referring to them via marks or their original SHA-1
> hash.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-fast-export.txt |    5 +++++
>  builtin/fast-export.c             |   23 +++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

Hmm, this smells somewhat fishy.

Wasn't G-F-I designed to be a common stream format for other SCMs to
generate streams, so that importers and exporters can be written once for
each SCM to interoperate?

This patch will allow you to write an importer that can only take a stream
with inlined blobs without any references to previous occurrences, but if
the exporter for an SCM that you are trying to interoperate with does not
support --inline-blobs, you are screwed.

What is the problem you are really trying to solve?  If it is "it is
cumbersome to keep track of blob references", wouldn't it be nicer to
instead make it easier for importers to support referenced blobs?

Just thinking aloud, but is it possible to write a filter that converts an
arbitrary G-F-I stream with referenced blobs into a G-F-I stream without
referenced blobs by inlining all the blobs?  Then other people do not have
to implement --inline-blobs to their own exporter.

If that is not possible, should/can we do something to at least allow
people to check if an existing stream is compatible with an importer that
cannot take referenced blobs without actually trying to run import (and
see it fail)?  Do we need a way to encourage people to add --inline-blobs
support to their exporters?  I suspect this series leads to make G-F-I
less useful by fragmenting the compatible subset of stream formats without
such effort, no?
