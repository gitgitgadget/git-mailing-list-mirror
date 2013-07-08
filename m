From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A local shared clone is now much slower
Date: Mon, 08 Jul 2013 08:00:09 -0700
Message-ID: <7vbo6d2j2e.fsf@alter.siamese.dyndns.org>
References: <20130708130355.647fffb6e5b6a453bfa0fa6e@canb.auug.org.au>
	<20130708073041.GA25072@sigill.intra.peff.net>
	<CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Git Mailing List <git@vger.kernel.org>,
	Linus <torvalds@linux-foundation.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:00:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwCvO-0001v9-9U
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001Ab3GHPAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:00:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33789 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab3GHPAP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:00:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E0652CD73;
	Mon,  8 Jul 2013 15:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j6bqp6VwFegCNCwhRpY7FACmkeE=; b=MAvQvQ
	r1kdHg74yB/bRx31YEQTbo0/NuzFhO+O3VT6Z9TuTWsCrohcghU7aSeF0i0TPiS1
	Lwd6VxegSxlgJ6qAvFEG5BSH7xTRi6m7/PaJyoPrqBO6QmIeFZb8JjPgVY7Zy5+u
	Q0NYHx8+kohwnR1QNnc4eH6VNU1wVGHUlRVNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NbzPHUqtk5JzeXNCxU7iTcyZXtd+IgVD
	QE33GjaJXuFiCvkIS0Sv9WboAVWsW9XHQUiKN1E5HBIJpxi8bOG2b2mr2kWnLBL7
	wLh/2r1LZbwJ4xRIBsDklaRHSiRb6AzPlv87mA6UN/mjYjHSqSwEmth4hlLDEudJ
	pSDHmTLUm5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 511A32CD72;
	Mon,  8 Jul 2013 15:00:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BDEF2CD71;
	Mon,  8 Jul 2013 15:00:11 +0000 (UTC)
In-Reply-To: <CACsJy8Chmm0=wDV4NQ+4Gh7KZYpbd9qkb=pNzkPeG-a-xiwVmw@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 8 Jul 2013 15:57:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 168141F8-E7DF-11E2-B48A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229860>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Jul 8, 2013 at 2:30 PM, Jeff King <peff@peff.net> wrote:
>> Subject: [PATCH] clone: drop connectivity check for local clones
>>
>> Commit 0433ad1 (clone: run check_everything_connected,
>> 2013-03-25) added the same connectivity check to clone that
>> we use for fetching. The intent was to provide enough safety
>> checks that "git clone git://..." could be counted on to
>> detect bit errors and other repo corruption, and not
>> silently propagate them to the clone.
>>
>> For local clones, this turns out to be a bad idea, for two
>> reasons:
>>
>>   1. Local clones use hard linking (or even shared object
>>      stores), and so complete far more quickly. The time
>>      spent on the connectivity check is therefore
>>      proportionally much more painful.
>
> There's also byte-to-byte copy when system does not support hardlinks
> (or the user does not want it) but I guess it's safe to trust the OS
> to copy correctly in most cases.

While that may be true, I do not think it matters that much.  The
check during transport is meant to guard against not just corruption
during the object transfer, but also against a corrupt source
repository, and your trust on "cp -R" only covers the "transfer"
part.  And that makes 2. below very relevant.

>>   2. Local clones do not actually meet our safety guarantee
>>      anyway.
>>      ...
>
> Faster clones make everybody happy :-)

Yup.

I think this deserves to be backported to 'maint' track for
1.8.3.x.  Here is an attempt to do so.

 builtin/clone.c           | 11 +++++++----
 t/t5710-info-alternate.sh |  8 +++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 035ab64..38a0a64 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -542,12 +542,15 @@ static void update_remote_refs(const struct ref *refs,
 			       const struct ref *mapped_refs,
 			       const struct ref *remote_head_points_at,
 			       const char *branch_top,
-			       const char *msg)
+			       const char *msg,
+			       int check_connectivity)
 {
 	const struct ref *rm = mapped_refs;
 
-	if (check_everything_connected(iterate_ref_map, 0, &rm))
-		die(_("remote did not send all necessary objects"));
+	if (check_connectivity) {
+		if (check_everything_connected(iterate_ref_map, 0, &rm))
+			die(_("remote did not send all necessary objects"));
+	}
 
 	if (refs) {
 		write_remote_refs(mapped_refs);
@@ -950,7 +953,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf);
+			   branch_top.buf, reflog_msg.buf, !is_local);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index 8956c21..5a6e49d 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -58,7 +58,13 @@ test_expect_success 'creating too deep nesting' \
 git clone -l -s D E &&
 git clone -l -s E F &&
 git clone -l -s F G &&
-test_must_fail git clone --bare -l -s G H'
+git clone --bare -l -s G H'
+
+test_expect_success 'invalidity of deepest repository' \
+'cd H && {
+	test_valid_repo
+	test $? -ne 0
+}'
 
 cd "$base_dir"
 
