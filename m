Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="b1qipxcP"
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C01702
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:52 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-423d9d508d1so6051131cf.1
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1701198531; x=1701803331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vmeNHyN2c0V60ZBnVmcpeDCxDkDyAskNROhNrlgkMg0=;
        b=b1qipxcP+T+FON0bdpTx6+zkn/mzZKUYc3C5yas+CbWci5+DGUUO3hLzi7d3onrOeH
         Z8HEjERg3qihq5t3oU4RbqkUb5FwBREtlfssP+kYkChw2DRzs97ZNVufQKaH8q1ZHpEL
         PUfX/101XtvNLKysUyLOj4aeOwo4P8OIhXE8QGaNTIpG+paNjcmz8uKo7HCQo+0qXAK8
         whAfKMiUAgQ/UqApIo3vUcxHa9aKH11tFGQdss5pGqkN7Z6Uj6Zb7rbBV/2T55rKpU9u
         sjdx3RC+IsjKcmufmfoB7MEO/ldchXJ2B3i/6/bf1EANpsur3HURkqqPAPSPDAbkuUDt
         +YrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701198531; x=1701803331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmeNHyN2c0V60ZBnVmcpeDCxDkDyAskNROhNrlgkMg0=;
        b=AQcuDKyNc3L6WQj+TYW2rJr6grBrWXSrmP5bO8j02cSLrGNE1kLn9vG/wy5s3LT11d
         n6XsWPGdKQhKTpV1oxw3WkQ1gueBEfwe4sRVGH/62oeRW36H/TdozEvXjDHtnistqisk
         UNkKYZbi0kCUknW9HOmQN9+BWmmLEzhngjfAD1dVuH+dB6bZ/VNtHfP5jltTgfRLpmvE
         3w6p7D4NiCd9JtDDe+2ziNdHqbeDN/1NOWDs0TJEJ41P+onndaR6X0g6k9fdFLYAHn4S
         8tMr+YO8VS0lcS9yR29PePsCQLtzMFPDFI1vgTKWM2l8ubxE/59eoiagJs/vDbB8L7NH
         HJWQ==
X-Gm-Message-State: AOJu0YyTrM1cGvLKsKd4Q3WhTz5CggCAHGlfyTPzZEukuIYFfVTiI8GV
	h08BIHHy8HDXH3ay1qnINsVWAr08ggseNqph57w=
X-Google-Smtp-Source: AGHT+IEzxAZAQ4K7axNN2gIMpvod88X2nlvkDx12/1G3ec9wP0tXTChnqyizDjx8lxuinzOZ9573QA==
X-Received: by 2002:ac8:5794:0:b0:41e:2d8e:b364 with SMTP id v20-20020ac85794000000b0041e2d8eb364mr22399252qta.53.1701198531477;
        Tue, 28 Nov 2023 11:08:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u6-20020a05622a14c600b00423a3f5ea75sm3254360qtx.21.2023.11.28.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 11:08:51 -0800 (PST)
Date: Tue, 28 Nov 2023 14:08:50 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 21/24] t/test-lib-functions.sh: implement `test_trace2_data`
 helper
Message-ID: <fb764fbacceb2796f2e9973ee10c3946978586c4.1701198172.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1701198172.git.me@ttaylorr.com>

Introduce a helper function which looks for a specific (category, key,
value) tuple in the output of a trace2 event stream.

We will use this function in a future patch to ensure that the expected
number of objects are reused from an expected number of packs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/test-lib-functions.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 9c3cf12b26..93fe819b0a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1874,6 +1874,20 @@ test_region () {
 	return 0
 }
 
+# Check that the given data fragment was included as part of the
+# trace2-format trace on stdin.
+#
+#	test_trace2_data <category> <key> <value>
+#
+# For example, to look for trace2_data_intmax("pack-objects", repo,
+# "reused", N) in an invocation of "git pack-objects", run:
+#
+#	GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects ... &&
+#	test_trace2_data pack-objects reused N <trace2.txt
+test_trace2_data () {
+	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
+}
+
 # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
 # sent to git-remote-https child processes.
 test_remote_https_urls() {
-- 
2.43.0.24.g980b318f98

