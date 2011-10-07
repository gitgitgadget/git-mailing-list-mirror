From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Fri, 07 Oct 2011 10:57:45 -0700
Message-ID: <7vaa9cwup2.fsf@alter.siamese.dyndns.org>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
 <CACsJy8DJs_cmCZegyPk=tB-bxWp4izrsTn8T=xeV1sU4fS5oTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 19:57:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCEgD-0004KH-Ql
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 19:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab1JGR5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 13:57:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59832 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821Ab1JGR5s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 13:57:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2636A0E;
	Fri,  7 Oct 2011 13:57:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CxEily9F7JpkW2sS8D4RknmF6ig=; b=E0Af2C
	wOY7Iww0V/yredJePNXWC7Aw6FHWfta+0XlSHjWC2lG5qXDVACHLmlgVcFI+wtN2
	VSUEeaMhGnQH+5iAVHW9WmIHEUtG58/9CpTyodEz7e0SElVyh2Gt7XIsJ2MEgKsO
	BPhuEkViVEPh+li9dxA0zkfgxg2ST25uLctas=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RPLBg5dN1JxkfcyzPkiasrGdGCncEfhA
	zztn7mRY5kzgkiXRQtX3SNViECoQPEA6lu5uIo0VnNPvkD5PSHyBnml9C4gRx3Ft
	PvPK9MdnLZTJMXhnI0HZtoeVmDjanq2DPKVHQMrrcUl/x0fvZ0yHCQkYNHpmIuxh
	2AoIasheMYI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F956A0D;
	Fri,  7 Oct 2011 13:57:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09FE66A0B; Fri,  7 Oct 2011
 13:57:46 -0400 (EDT)
In-Reply-To: <CACsJy8DJs_cmCZegyPk=tB-bxWp4izrsTn8T=xeV1sU4fS5oTQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 7 Oct 2011 18:16:04 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD48CF60-F10D-11E0-9F27-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183091>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> There may be a solution to mix depth limit and negative pathspec. I
> haven't thought carefully about that because I lean towards a simpler
> behaviour that only allows one negation level: a file is in if it
> matches any positive pathspecs and none of negative ones.

I tend to think it probably is acceptable solution to define "struct
pathspec" to have one positive and one negative set, traversing and
declaring a match on what matches something from the positive set only if
it does not match anything in the negative set.

That is similar to how we define revision ranges in the sense that the
range notation to have two ranges (A..B C..D) does not mean union of two
sets (A..B + C..D), but is difference between two unions ((B D)-(A C)).

> This is enough if narrow clones consist of positive pathspec only. I
> really doubt if users would want to make a narrow clone that "contains
> A but not A/B, storage-wise".

And if you define "struct pathspec" to have one positive and one negative
set, you do not have to limit narrow clone only to positive. The repository
specific narrow pathspec will have one such "struct pathspec", but the
user may give us from the command line another "struct pathspec". At
runtime, we would merge them to form into one negative and one positive
set, and apply the same rule: nothing that matches any negative will
appear in the traversal or in the output.
