From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the underlying protocol used by shallow
 repositories and --depth commands.
Date: Tue, 07 Jun 2011 16:01:22 -0700
Message-ID: <7vlixd456l.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
 <7vvcwi95yi.fsf@alter.siamese.dyndns.org>
 <loom.20110606T213817-376@post.gmane.org>
 <7v1uz55r24.fsf@alter.siamese.dyndns.org>
 <loom.20110607T224355-216@post.gmane.org>
 <7vr57547sj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Neronskiy <zakmagnus@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5HF-00059A-5o
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1FGXBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:01:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab1FGXBb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:01:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3DA7361F2;
	Tue,  7 Jun 2011 19:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CBLNcdFxFbJsRjbJPFSwN+zQIKg=; b=RUQSaj
	7lZEdRjx1iqFxyanqlDycQAXTAHt67dR3TuqmB9pidcZfQmqo/QY6DLghSbGv5Sh
	DrY6GLxBRasrFToutfis17gnuAC+qNhQhL+x3C/ys4FVKyTjUhVhRaqiA7D+V51C
	xoyow7j18dgQBm+bp6JQY2WE0ODGKFB1vFV+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IanKdD0nCiso+yh93qfaKmPpLdvhAEVu
	Pl0ckCjucgSn3OHMS0hzbPwrmM8DrBSFgTlh9R6wDZifUyVw8ehGxBzSQkCF2Xwh
	rcJgIxZaWgZR8FLmI4RH/8MvYagChPPAhhqoyPN1zxQ5HZqpoOzyPD4/lnV3mGCD
	HIuqDShLROc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A8E061ED;
	Tue,  7 Jun 2011 19:03:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E38ED61E8; Tue,  7 Jun 2011
 19:03:33 -0400 (EDT)
In-Reply-To: <7vr57547sj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 07 Jun 2011 15:05:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E5E5C14-915A-11E0-812B-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175277>

Junio C Hamano <gitster@pobox.com> writes:

> Alex Neronskiy <zakmagnus@google.com> writes:
>
>> The part of the document I'm referring to starts at line 221 and reads: 
>>
>>  Once all the "want"s (and optional 'deepen') are transferred,
>>  clients MUST send a flush-pkt. If the client has all the references
>>  on the server, client flushes and disconnects.
>>
>> And I believe this refers to the code path beginning at line 308 of fetch-pack.c:
>>
>>         if (!fetching) {
>>                 strbuf_release(&req_buf);
>>                 packet_flush(fd[1]);
>>                 return 1;
>>         }
>>
>> Am I wrong? 
>
> Ah, I overlooked that codepath, but if that if statement triggered, that
> would mean fetching is still 0, which in turn means that you never sent
> any "want", so "Once all the 'want's' (and optional 'deepen') are
> transferred" is not even true, is it?

Also I suspect that this might not even trigger. fetching will stay 0 only
when all the refs->old_sha1 refer to commits already marked as COMPLETE, but
everything_local() would already have covered that case and returned 1.

The code dates back to 2759cbc (git-fetch-pack: avoid unnecessary zero
packing, 2005-10-18) and I tend to trust what Linus wrote, but in that
much simpler version of the code, I think the check is redundant.

In either case, I think what the server sees (in other words, what goes
over the wire at the protocol level) is the same. The client receives
references and capabilities, and sends the flush without giving any "want"
to the server.

And that is exactly what is described in the first paragraph of "Packfile
Negotiation" section.

I am inclined to conclude that the original documentation "If the client
has all the references on the server, client flushes and disconnects",
while technically not incorrect, is redundant (because that particular
behaviour on-the-wire is already spelled out in the first paragraph), and
misleading (because that condition is determined by the client without
sending "want" etc., but the second paragraph "Once the client has ..., it
will begin telling the server..." that comes way before this "client can
quit without requesting anything" gives a false impression that the client
will spend all these effort of sending "want" and can flush and disconnect.

In fact the original does not say the client should not ask for objects it
already has (as COMPLETE) with "want", and as you noticed, the expression
"has all the references" is probably the source of confusion. It should
have said "If the client did not send any "want", it may flush and
disconnect".  Both the original and your update will allow an incorrectly
implemented client to send "want"s, realize that it does not want any, and
then flush to disconnect, but then the server will have to try to produce
a pack to send to the client, which is certainly not what we wanted to
specify.

So I would suggest removing the later part of the paragraph, and update
the first paragraph of the section instead.

Perhaps like this...

 Documentation/technical/pack-protocol.txt |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 369f91d..f860f2a 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -179,14 +179,15 @@ and descriptions.
 
 Packfile Negotiation
 --------------------
-After reference and capabilities discovery, the client can decide
-to terminate the connection by sending a flush-pkt, telling the
-server it can now gracefully terminate (as happens with the ls-remote
-command) or it can enter the negotiation phase, where the client and
-server determine what the minimal packfile necessary for transport is.
-
-Once the client has the initial list of references that the server
-has, as well as the list of capabilities, it will begin telling the
+After reference and capabilities discovery, the client can decide to
+terminate the connection by sending a flush-pkt, telling the server it can
+now gracefully terminate, and disconnect, when it does not need any pack
+data. This can happen with the ls-remote command, and also can happen when
+the client already is up-to-date.
+
+Otherwise, it enters the negotiation phase, where the client and
+server determine what the minimal packfile necessary for transport is,
+by telling the
 server what objects it wants and what objects it has, so the server
 can make a packfile that only contains the objects that the client needs.
 The client will also send a list of the capabilities it wants to be in
@@ -219,8 +220,8 @@ If client is requesting a shallow clone, it will now send a 'deepen'
 line with the depth it is requesting.
 
 Once all the "want"s (and optional 'deepen') are transferred,
-clients MUST send a flush-pkt. If the client has all the references
-on the server, client flushes and disconnects.
+clients MUST send a flush-pkt, to tell the server side that it is
+done sending the list.
 
 TODO: shallow/unshallow response and document the deepen command in the ABNF.
 
