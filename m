Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JfdS4I4v"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1933C10F0
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 15:17:45 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BCC41C03BE;
	Tue, 12 Dec 2023 18:17:42 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Mud1f0vr3hx7nV4T11jp28RdmJ7szOtwf2gnz9
	58Y7Y=; b=JfdS4I4v+6RfUsMg1uLjosin7aor/+dWU+S+fm+rVjFt19AwAMT/tr
	fevQrlJvQHqNgRCDJ3oi7sJHmOlzedU3TsbL5clsIIx0DCT8SJE/IjVio6EauvZI
	vPhcMjCiry72G6UIJYGn0+uMDVromnRyixldgiN5mFr98gofrUAAE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22FFF1C03BD;
	Tue, 12 Dec 2023 18:17:42 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 818631C03BA;
	Tue, 12 Dec 2023 18:17:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <CAMmZTi-U_ufzoBLCDWKbrf=3GZzGszxnM1_Pu6ufBeoYjj7Gdw@mail.gmail.com>
	(Joanna Wang's message of "Fri, 1 Dec 2023 12:01:54 +0800")
References: <xmqqttpmtnn5.fsf@gitster.g>
	<20231116054437.2343549-1-jojwang@google.com>
	<xmqqsf56ql14.fsf@gitster.g> <xmqqil62qfvr.fsf@gitster.g>
	<CAMmZTi-U_ufzoBLCDWKbrf=3GZzGszxnM1_Pu6ufBeoYjj7Gdw@mail.gmail.com>
Date: Tue, 12 Dec 2023 15:17:40 -0800
Message-ID: <xmqqedfrovsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5E9E1B6-9944-11EE-9CBB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Joanna Wang <jojwang@google.com> writes:

>> Cumulatively, aside from the removal of the t/#t* file, here is what
>> I ended up with so far.
>
> I want to double check if I should followup here.
> I assumed that you had already applied these final fixes on my behalf,
> similar to my patch for enabling attr for `git-add`. But if I was wrong,
> I'm happy to send another update with all the fixes.

I've squashed the fix in, so no need to resend only to patch up what
I pointed out earlier.

The end result fails t0003 under GIT_TEST_PASSING_SANITIZE_LEAK
though.  As the synthetic attribute values are allocated without
being in the hashmap based on the value read from .gitattributes
files, somebody needs to hold pointers to them *and* we need to
avoid allocating unbounded number of them.

The attached is one possible way to plug the leak; I am not sure if
it is the best one, though.  One thing I like about the solution is
that the approach makes sure that the mode attributes we would ever
return are very tightly controlled and does not allow a buggy code
to come up with "mode" to be passed to this new helper function to
pass random and unsupported mode bits without triggering the BUG().

 attr.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git c/attr.c w/attr.c
index b03c20f768..679e42258c 100644
--- c/attr.c
+++ w/attr.c
@@ -1250,10 +1250,34 @@ static struct object_id *default_attr_source(void)
 	return &attr_source;
 }
 
+static const char *interned_mode_string(unsigned int mode)
+{
+	static struct {
+		unsigned int val;
+		char str[7];
+	} mode_string[] = {
+		{ .val = 0040000 },
+		{ .val = 0100644 },
+		{ .val = 0100755 },
+		{ .val = 0120000 },
+		{ .val = 0160000 },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mode_string); i++) {
+		if (mode_string[i].val != mode)
+			continue;
+		if (!*mode_string[i].str)
+			snprintf(mode_string[i].str, sizeof(mode_string[i].str),
+				 "%06o", mode);
+		return mode_string[i].str;
+	}
+	BUG("Unsupported mode 0%o", mode);
+}
+
 static const char *builtin_object_mode_attr(struct index_state *istate, const char *path)
 {
 	unsigned int mode;
-	struct strbuf sb = STRBUF_INIT;
 
 	if (direction == GIT_ATTR_CHECKIN) {
 		struct object_id oid;
@@ -1287,8 +1311,8 @@ static const char *builtin_object_mode_attr(struct index_state *istate, const ch
 		else
 			return ATTR__UNSET;
 	}
-	strbuf_addf(&sb, "%06o", mode);
-	return strbuf_detach(&sb, NULL);
+
+	return interned_mode_string(mode);
 }
 
 

