From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] combine-diff: Fast changed-to-all-parents paths scanning
Date: Mon, 03 Feb 2014 15:26:40 -0800
Message-ID: <xmqqk3dbbwwf.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASuf-0002fU-9x
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaBCX0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:26:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbaBCX0n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:26:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7F4369E81;
	Mon,  3 Feb 2014 18:26:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Z1CNx6e+2gRke/NmXZ/+lGX9Fo=; b=B6BDaY
	9bU4c7gCVo/fiG3WgYN/GjdCCt304nNilDfHAicJYvloa0bZjk3u9KbmSEgiBI0C
	TO3lm3exr/uS1pY0x3RDXv1HKgeEEo2ZBVCWQS54Z6EQzr/VNdTD/L0gEDpcsp64
	cTRyZjzt4h46xnyLEQ3aWnISNApIYrwty4Uxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZGeuc6PUQTm2DizMUCo3FYaFi1N1OalN
	3bMGInZvZSdDh7ACpfOj3s7NgVUNjhLvHgs0Ngy8U/cTnHrvKhDOYPdSia6rJIx6
	5iMNfaibQBt5EDsPpBnjkNGV4L5wbQLhf0jJ7uDRf5V6S13GZXd7PdFiywyBluR6
	PrMe/BJsRWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A1AA69E80;
	Mon,  3 Feb 2014 18:26:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B104469E7E;
	Mon,  3 Feb 2014 18:26:41 -0500 (EST)
In-Reply-To: <c0ad49d850377aedffa0a593fef8738112019b01.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:21 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A331F44E-8D2A-11E3-8111-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241495>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> As was recently shown (c839f1bd "combine-diff: optimize
> combine_diff_path sets intersection"), combine-diff runs very slowly. In
> that commit we optimized paths sets intersection, but that accounted
> only for ~ 25% of the slowness, and as my tracing showed, for linux.git
> v3.10..v3.11, for merges a lot of time is spent computing
> diff(commit,commit^2) just to only then intersect that huge diff to
> almost small set of files from diff(commit,commit^1).
>
> That's because at present, to compute combine-diff, for first finding
> paths, that "every parent touches", we use the following combine-diff
> property/definition:
>
>     D(A,P1...Pn) = D(A,P1) ^ ... ^ D(A,Pn)      (w.r.t. paths)
>
> where
>
>     D(A,P1...Pn) is combined diff between commit A, and parents Pi
>
> and
>
>     D(A,Pi) is usual two-tree diff Pi..A

and A ^ B means what???

I do like the approach of walking the tree entries and stop as
shallowly as possible without recursing.
