Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213A44C65
	for <git@vger.kernel.org>; Sun, 17 Dec 2023 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTAhYjQ+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso1969542b3a.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2023 06:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702824102; x=1703428902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNEk2OqAFB0M16I9BuVYseFIfPuU3rmPfSd/KC8MluU=;
        b=DTAhYjQ+8rARrlhmEWh0HoGhnpbpd1d5GvF+xcosuajWgdiGTeB9g4sRqsmQojI9HL
         vaCXj0DktRGFjMgfHlJzGDWph81CmF1sKFsOOHHdhkYkVX8S0S9CDQZifoKWm9XpqADh
         9UD4spVXbCieR4N7SwvtFtcgI6zv57Ml9nqV9u80lcGlJqS+lKEUIaQX1Q9L+kgfqw4E
         rhkKr/v2CK58B17zCxURj1Hm8rDFQu5NAbtn9i8NaAGDWSoi8hSBK6PbQNVNS/xpngpD
         E0oROti96ybB4kIzPiK+tiO9SDKQTj3noU7MM9o0VZDBxRVjEpQsXQBT0W6QeQbBr1pW
         Rapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702824102; x=1703428902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNEk2OqAFB0M16I9BuVYseFIfPuU3rmPfSd/KC8MluU=;
        b=OMfx8otRNFF3wTwQP+wA8ZoNsh2CRH5s1RLgAhkPuJkZpoy2fYEv2G+Jn9eiKKfe3i
         4h1FBuUaoGFKRhzISpsHyEl8YDFkJs7zaEfF54gZnUJPbiAlrDrdKZCRVZ+/1kFvefXo
         j/UH7cU5QcrtE7/jveQrT3e6nxmuVzChOnn4brXIItfTXZDWaC+SrQpAKcBhg6Rm9l60
         /TG3VkGHPJ2RSy869DrB9dYrCXJMGbM3c/8Hmy4YoGFy2et3WlQYeM2W7FBZ1mVaD37q
         XlqNkOKIv2JEKwB5cpyjOI48sTqAukjvwCFGikN4nStMa/8gzlHVDF7Y84PP936yVVh9
         4gaw==
X-Gm-Message-State: AOJu0YxjRQmkhzZY0WK0fKgzlnSu4zs8y+tqSumYsvSIdgbXxsvXDY4A
	AZx6uzvp2T8MOnfXLvgVduLc1U8judU=
X-Google-Smtp-Source: AGHT+IHdUrNYUckSKPvWvVCIB21CMLroZtU5ymQ4/yCdqfmXfq9/+f8mpPC+rrtUEEI9srqtqXMSvA==
X-Received: by 2002:a05:6a00:aca:b0:6ce:55d1:8b70 with SMTP id c10-20020a056a000aca00b006ce55d18b70mr17432695pfl.44.1702824102382;
        Sun, 17 Dec 2023 06:41:42 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i4-20020a63cd04000000b005c1ce3c960bsm16276657pgg.50.2023.12.17.06.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:41:42 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Tan <jonathantanmy@google.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 2/3] pkt-line: memorize sideband fragment in reader
Date: Sun, 17 Dec 2023 22:41:37 +0800
Message-Id: <5942b74cab4ffe8509169a0a4b8442019fd05e01.1702823801.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1696425168.git.zhiyou.jx@alibaba-inc.com> <cover.1702823801.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

When we turn on the "use_sideband" field of the packet_reader,
"packet_reader_read()" will call the function "demultiplex_sideband()"
to parse and consume sideband messages. Sideband fragment which does not
end with "\r" or "\n" will be saved in the sixth parameter "scratch"
and it can be reused and be concatenated when parsing another sideband
message.

In "packet_reader_read()" function, the local variable "scratch" can
only be reused by subsequent sideband messages. But if there is a
payload message between two sideband fragments, the first fragment
which is saved in the local variable "scratch" will be lost.

To solve this problem, we can add a new field "scratch" in
packet_reader to memorize the sideband fragment across different calls
of "packet_reader_read()".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 pkt-line.c             | 5 ++---
 pkt-line.h             | 3 +++
 t/t0070-fundamental.sh | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index af83a19f4d..5943777a17 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -592,12 +592,11 @@ void packet_reader_init(struct packet_reader *reader, int fd,
 	reader->options = options;
 	reader->me = "git";
 	reader->hash_algo = &hash_algos[GIT_HASH_SHA1];
+	strbuf_init(&reader->scratch, 0);
 }
 
 enum packet_read_status packet_reader_read(struct packet_reader *reader)
 {
-	struct strbuf scratch = STRBUF_INIT;
-
 	if (reader->line_peeked) {
 		reader->line_peeked = 0;
 		return reader->status;
@@ -620,7 +619,7 @@ enum packet_read_status packet_reader_read(struct packet_reader *reader)
 			break;
 		if (demultiplex_sideband(reader->me, reader->status,
 					 reader->buffer, reader->pktlen, 1,
-					 &scratch, &sideband_type))
+					 &reader->scratch, &sideband_type))
 			break;
 	}
 
diff --git a/pkt-line.h b/pkt-line.h
index 954eec8719..be1010d34e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -194,6 +194,9 @@ struct packet_reader {
 
 	/* hash algorithm in use */
 	const struct git_hash_algo *hash_algo;
+
+	/* hold temporary sideband message */
+	struct strbuf scratch;
 };
 
 /*
diff --git a/t/t0070-fundamental.sh b/t/t0070-fundamental.sh
index 297a7f772e..275edbf6e7 100755
--- a/t/t0070-fundamental.sh
+++ b/t/t0070-fundamental.sh
@@ -81,7 +81,7 @@ test_expect_success 'unpack-sideband: --chomp-newline (default)' '
 	test_cmp expect-err err
 '
 
-test_expect_failure 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
+test_expect_success 'unpack-sideband: packet_reader_read() consumes sideband, no chomp payload' '
 	test_when_finished "rm -f expect-out expect-err" &&
 	test-tool pkt-line send-split-sideband >split-sideband &&
 	test-tool pkt-line unpack-sideband \
-- 
2.41.0.232.g2f6f0bca4f.agit.8.0.4.dev

