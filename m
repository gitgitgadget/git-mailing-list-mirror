From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] hashmap.h: make sure map entries are tightly packed
Date: Sun, 09 Feb 2014 00:35:55 +0100
Message-ID: <52F6BF5B.9090807@gmail.com>
References: <xmqqtxcatze2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 00:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCHRg-0003S0-CM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 00:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbaBHXfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 18:35:54 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:51170 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaBHXfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 18:35:53 -0500
Received: by mail-ea0-f176.google.com with SMTP id h14so2211917eaj.21
        for <git@vger.kernel.org>; Sat, 08 Feb 2014 15:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eDjxxkzcUfZzIAUENWKk0eFZ0f/L5UTSfoZ1P63shGA=;
        b=HxcAFHZ/1ttDBoGLYiRqp/BZR2g+8BmuzeRpy0ZbpnY58Ad8H+2HHrTFSj2Fx70ZhC
         2w9vY6MDuAyOZ6d7z8LbUKfKxCASsBHPpUxQkzd3ly2rjRKcPIVFXQBKUYwIeluBwWFP
         6gaZQwXuSVRiiTiHsaBdofNT1ko6gaKX+3qsZbzLazaMPuO0b0T2IpIvfgbDzpTIS+zS
         bkdbzzyaDdeJQNL0r4KjY0Mm+lFpvy+TVtctc6nzKojPCdvGuf45XsPrbWjcfwEjrX2I
         BiKR5xLkbPMpXXZNb01hHNTTiRZ9OVCWAfjLZz6SsahpvsbUwxeDGSNoq+/KvZswq78X
         0wLA==
X-Received: by 10.15.26.199 with SMTP id n47mr26444752eeu.30.1391902551720;
        Sat, 08 Feb 2014 15:35:51 -0800 (PST)
Received: from [10.1.100.54] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id 8sm34451575eef.1.2014.02.08.15.35.50
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Feb 2014 15:35:51 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqtxcatze2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241865>

Am 07.02.2014 21:56, schrieb Junio C Hamano:
> * kb/fast-hashmap (2014-01-03) 19 commits
>  - hashmap.h: make sure map entries are tightly packed
>   (merged to 'next' on 2014-01-03 at dc85001)
[...]
>  The tip one does not seem to have reached concensus (yet).

See discussion leading up to $gmane/239433.

I'd like to finish this up, so here are the options regarding the tip commit as I see them, ordered least risk to broadest compiler support:

1.) Drop the tip commit

Wastes 4 bytes of memory per entry on 64-bit platforms (still an improvement wrt memory, hash.[ch] wastes 4 bytes per bucket).
Works on all platforms.


2.) Keep the tip commit, i.e. "__attribute__(__packed__)"

Currently in pu at 036ad21.
Fixes the problem for 64-bit GCC only.
May fail on HP, all other platforms #define __attribute__ /* empty */


3.) Replace with the patch below, i.e. "#pragma pack"

Same as $gmane/239430 + $gmane/239433.
Should fix the problem for most compilers, with unit-test to make sure.
May fail on IRIX/MIPSPro (supposedly wants "#pragma pack(0)" to reset packing to default).


I don't know whether IRIX is still relevant (support ended Dec 2013). But if we fix this issue, I'd like to support as many platforms as possible, even though I can't test them all. The inline __attribute__ syntax is a dead end in that respect, so I'd suggest to go for #pragma pack (3). At the very least we shouldn't stall the rest of the patch series on a hunch that the last (unfortunately non-standard) patch may break on some legacy system.

Cheers,
Karsten

----8<----
Subject: [PATCH] hashmap.h: make sure map entries are tightly packed

Extending 'struct hashmap_entry' with an int-sized member shouldn't waste
memory on 64-bit systems. This is already documented in api-hashmap.txt,
but struct hashmap_entry needs to be packed for this to work. E.g.

 struct name_entry {
   struct hashmap_entry ent; /* consists of pointer + int */
   int namelen;
   char *name;
 };

should be 24 instead of 32 bytes.

Packing structures is compiler-specific, most compilers support [1]:

 #pragma pack(n) - to set structure packing
 #pragma pack()  - to reset structure packing to default

Compilers are supposed to ignore unknown #pragmas, so using this without
further #if <compiler> guards should be safe.

Wasting a few bytes for padding is acceptable, however, compiling the rest
of git with packed structures (and thus mis-aligned arrays of structs) is
not. Add a test to ensure that '#pragma pack()' really resets the packing.

[1] Compiler docs regarding #pragma pack:
http://gcc.gnu.org/onlinedocs/gcc-4.6.2/gcc/Structure_002dPacking-Pragmas.html#Structure_002dPacking-Pragmas
http://msdn.microsoft.com/en-us/library/2e70t5y1%28v=vs.80%29.aspx
http://h21007.www2.hp.com/portal/download/files/unprot/aCxx/Online_Help/pragmas.htm#pragma-PACK
http://clang.llvm.org/docs/UsersManual.html#microsoft-extensions
http://uw714doc.sco.com/en/SDK_cprog/_Preprocessing_Directives.html
http://osr507doc.sco.com/en/tools/ANSI_F.3.13_Preprocessing.html
http://docs.oracle.com/cd/E19422-01/819-3690/Pragmas_App.html#73499
http://publib.boulder.ibm.com/infocenter/comphelp/v7v91/index.jsp?topic=%2Fcom.ibm.vacpp7a.doc%2Fcompiler%2Fref%2Frnpgpack.htm

Supposedly wants #pragma pack(0) to reset:
http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi/0650/bks/SGI_Developer/books/Pragmas/sgi_html/ch04.html

Not supported:
http://software.intel.com/sites/products/documentation/doclib/iss/2013/compiler/cpp-lin/GUID-DD32852C-A0F9-4AC6-BF67-D10D064CC87A.htm

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 hashmap.h          |  7 +++++++
 t/t0011-hashmap.sh |  6 ++++++
 test-hashmap.c     | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/hashmap.h b/hashmap.h
index a816ad4..93b330b 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -15,10 +15,17 @@ extern unsigned int memihash(const void *buf, size_t len);
 
 /* data structures */
 
+/*
+ * Set struct packing to 4 so that we don't waste memory on 64-bit systems.
+ * Struct hashmap_entry is used as prefix to other (un-packed) structures,
+ * so this won't cause alignment issues e.g. for odd elements in an array.
+ */
+#pragma pack(4)
 struct hashmap_entry {
 	struct hashmap_entry *next;
 	unsigned int hash;
 };
+#pragma pack()
 
 typedef int (*hashmap_cmp_fn)(const void *entry, const void *entry_or_key,
 		const void *keydata);
diff --git a/t/t0011-hashmap.sh b/t/t0011-hashmap.sh
index 391e2b6..3f3c90b 100755
--- a/t/t0011-hashmap.sh
+++ b/t/t0011-hashmap.sh
@@ -237,4 +237,10 @@ test_expect_success 'grow / shrink' '
 
 '
 
+test_expect_success '"#pragma pack()" resets packing to default' '
+
+	test_hashmap "pragma-pack" "ok"
+
+'
+
 test_done
diff --git a/test-hashmap.c b/test-hashmap.c
index f5183fb..64bd9ec 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -36,6 +36,12 @@ static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
 	return entry;
 }
 
+struct pointer_int
+{
+	void *ptr;
+	int i;
+};
+
 #define HASH_METHOD_FNV 0
 #define HASH_METHOD_I 1
 #define HASH_METHOD_IDIV10 2
@@ -136,6 +142,7 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
  * remove key -> NULL / old value
  * iterate -> key1 value1\nkey2 value2\n...
  * size -> tablesize numentries
+ * pragma-pack -> ok / failure
  *
  * perfhashmap method rounds -> test hashmap.[ch] performance
  */
@@ -239,6 +246,16 @@ int main(int argc, char *argv[])
 			/* print table sizes */
 			printf("%u %u\n", map.tablesize, map.size);
 
+		} else if (!strcmp("pragma-pack", cmd)) {
+
+			if ((sizeof(struct pointer_int) % sizeof(void *)) == 0)
+				printf("ok\n");
+			else
+				printf("sizeof(pointer+int) (%u) is not a "
+				       "multiple of sizeof(pointer) (%u)!\n",
+				       (unsigned) sizeof(struct pointer_int),
+				       (unsigned) sizeof(void *));
+
 		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
-- 
1.8.5.2.msysgit.1
