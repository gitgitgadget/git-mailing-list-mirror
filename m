From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 5/5] cache: Use ce_norm_sha1().
Date: Tue, 20 Apr 2010 00:25:00 -0700
Message-ID: <7vsk6qio1f.fsf@alter.siamese.dyndns.org>
References: <cover.1271432034.git.grubba@grubba.org>
 <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Tue Apr 20 09:25:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O47pc-0005hn-AV
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 09:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753Ab0DTHZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 03:25:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab0DTHZJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 03:25:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B5D5A40C7;
	Tue, 20 Apr 2010 03:25:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wTHTd6NSAjTP
	Xt+Igg1gSZCwocI=; b=X+A2wNs2YmwJ5r2kQvpDwLkycU94nioTu+GUj99hk9aH
	9JrePsRrcztA8B79rjU2Mbq1QTI+OTXnoDC7WHD2szJAbsYP2oaf072ULzFROYTT
	dQ+TLU6gRQA4aqx7gvS35Pm4Gp4x1DFO4lJi7pYbqbhRHys1tRqDVewqKh8scG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jkDk/w
	ZM9kEFhmENj6CskOMlfdzpaC6EOpcmvLnDxQTkzSRp2kOayKJrt5+8N4hd0OtTVH
	y1Aaq1cASfd2q4+UPl8tIFX5cB74uXvJKSNEgylqkmpDh8z19Sl9x0I/Na6nS36j
	JD1KaFUQ93LDRyWFEs7l3SCZ2XU4kMO93dCoE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E36A40C6;
	Tue, 20 Apr 2010 03:25:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACA5BA40C5; Tue, 20 Apr
 2010 03:25:02 -0400 (EDT)
In-Reply-To: <c68d98b384086925da0194e560ae01d83a29f80c.1271432034.git.grubba@grubba.org>
 ("Henrik =?utf-8?Q?Grubbstr=C3=B6m=22's?= message of "Fri\, 16 Apr 2010
 18\:10\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D7676892-4C4D-11DF-B403-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145352>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> When the conversion filter for a file is changed, the file may get
> listed as modified even though the user has not made any changes to i=
t.
> This patch makes the index ignore such changes. It also makes git-dif=
f
> compare with the normalized content rather than the original content.

Hmm, I am not happy with this.  A typical use case I am imagining goes
like this:

 0. You have a project with LF line ending.  You clone to a filesystem
    that needs autocrlf but somehow it is not set, and end up with file=
s
    with LF line ending in your working tree.

 1. You notice the mistake, and set autocrlf.  "git diff" does not say
    anything, as the index is clean.

 2. Once you fixed the line endings in the working tree files, however,
    "git diff" will say the files are different, but there is no actual
    change (i.e. you see "diff --git a/file b/file" and nothing else).

 3. "git update-index --refresh" does not improve the situation, as it
    (thinks) it knows the blob and the working tree file are different.

I was hoping to see a solution where you will add a stronger version of
"refresh" without having to do anything else other than recording "how =
did
I munge the file in the working tree to produce the blob".  The third s=
tep
would change to:

 3. "git update-index --refresh" notices that the conversion parameters
    are different since the last time the files in the working tree wer=
e
    looked at (i.e. immediately after a "clone", working tree files are
    what git wrote out using convert_to_working_tree() and you know wha=
t
    conversion you used; after the user modified files in the working t=
ree
    and said "git add", you know you what conversion parameters you ran
    convert_to_git() with to produce blobs).  The paths that has differ=
ent
    conversion parameters are re-indexed to see if they hash to the sam=
e
    sha1 as recorded in the index.  If they have changed, their index
    entries are left intact (i.e. you will still show the differences);
    otherwise you update the cached stat information for their index
    entries.

The above example scenario is about crlf conversion, but the same idea
should apply to other types of conversions (e.g. smudge/clear filter
pair), no?

I can see that it would be benefitial to store what conversions were us=
ed
to turn the input into the canonical version that resulted in the objec=
t
store and registered in the index, but I am not sure why the re-indexed
versions need to be even stored in the index (either in-core, let alone
on-disk) nor produce new blob objects.  What am I missing?
