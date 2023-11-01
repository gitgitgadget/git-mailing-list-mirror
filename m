Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0A61A263
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VesznDu4"
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F1410E
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 12:24:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 654A55B0C2;
	Wed,  1 Nov 2023 19:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1698866666;
	bh=QqTJ6YUHiQx4964vc+cE/iPGOS8b66Z495vblrlzsO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=VesznDu4jAulAOXFW4v7OwMh3sH1azVtn3KC5EUppryeTRzWxgCc95tTMjRCkwmui
	 LypaATFaVtqnWGhgzfNokK2kjV0U6nakbHC2AwVmu+2ExXCGLEAYT5+hOe9BSie+/h
	 BnuL3CURu1AXx9hMwRvnRHNBIyRZ35JnLyOM1io9Y++9PCZ+eoTkWvMyivaojXJ/hM
	 wcfJmnU2/IIeEQNf/14uFMBmgn9lGQ6liZbI/4L9kSsvyCEKVO3kiTPnJAncNUFAiY
	 glCQHx3TS6zAeBu/zpBUvYrnyQS2+bMs7FNCV+rgCdSKH+UerwLHrpcSptn2eG7U8H
	 l81zygVD7BMnpoqj+SlOLYKHOrrvt3U2VFjJWchicIl8YHRd72NzDpNmPSZlHToq67
	 jQWMsLDGS0g8p8po0r8flp2kibpJumNQQMBcaP1TRNGM15HW0iYMzIELjAwc4qzZ46
	 t+idQoyoJQ+Kx/75LScCRukkm1xNOv9vutF43YLG4tijYYsNfen
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>,
	=?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 0/2] Object ID support for git merge-file
Date: Wed,  1 Nov 2023 19:24:17 +0000
Message-ID: <20231101192419.794162-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces an --object-id option to git merge-file such
that, instead of reading and writing from files on the system, it reads
from and writes to the object store using blobs.

Changes from v2:
* Include a patch from Martin to pre-improve the documentation
* Remove incorrect portion of commit message

Changes from v1:
* Improve error handling
* Re-add `-p` argument for documentation

Martin Ågren (1):
  git-merge-file doc: drop "-file" from argument placeholders

brian m. carlson (1):
  merge-file: add an option to process object IDs

 Documentation/git-merge-file.txt | 38 ++++++++++++++------
 builtin/merge-file.c             | 62 +++++++++++++++++++++++---------
 t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 26 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  21a96acf42 git-merge-file doc: drop "-file" from argument placeholders
1:  9cd4220a3b ! 2:  b1978a7b5c merge-file: add an option to process object IDs
    @@ Commit message
         Teach it an `--object-id` option which means that its arguments are
         object IDs and not files to allow it to do so.
     
    -    Since we obviously won't be writing the data to the first argument,
    -    imply the -p option so we write to standard output.
    -
         We handle the empty blob specially since read_mmblob doesn't read it
         directly and otherwise users cannot specify an empty ancestor.
     
    @@ Commit message
     
      ## Documentation/git-merge-file.txt ##
     @@ Documentation/git-merge-file.txt: SYNOPSIS
    + [verse]
      'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
      	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
    - 	[--[no-]diff3] <current-file> <base-file> <other-file>
    -+'git merge-file' --object-id [-L <current-name> [-L <base-name> [-L <other-name>]]]
    -+	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
    -+	[--[no-]diff3] <current-oid> <base-oid> <other-oid>
    +-	[--[no-]diff3] <current> <base> <other>
    ++	[--[no-]diff3] [--object-id] <current> <base> <other>
      
      
      DESCRIPTION
    -@@ Documentation/git-merge-file.txt: however, these conflicts are resolved favouring lines from `<current-file>`,
    - lines from `<other-file>`, or lines from both respectively.  The length of the
    +@@ Documentation/git-merge-file.txt: however, these conflicts are resolved favouring lines from `<current>`,
    + lines from `<other>`, or lines from both respectively.  The length of the
      conflict markers can be given with the `--marker-size` option.
      
     +If `--object-id` is specified, exactly the same behavior occurs, except that
