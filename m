From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2013, #02; Fri, 6)
Date: Wed, 18 Dec 2013 14:10:20 +0100
Message-ID: <52B19EBC.50609@gmail.com>
References: <xmqqk3fh1qrc.fsf@gitster.dls.corp.google.com> <52A37D70.3090400@gmail.com> <87fvq41esw.fsf@thomasrast.ch> <52A3A1F5.3080906@gmail.com> <87lhzvhceb.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098> <52A5CDB0.2020206@gmail.com> <20131209200820.GU29959@google.com> <52A64FE9.5010004@gmail.com> <20131209234500.GY29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 14:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtGtX-0006GU-7A
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 14:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064Ab3LRNK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 08:10:26 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:47311 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab3LRNKV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 08:10:21 -0500
Received: by mail-ee0-f43.google.com with SMTP id c13so3494230eek.16
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 05:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5Vs9jKKeBm0HLwHoJI0bMgp7pH38cik6BxGOWgQZwxA=;
        b=cICOPpqiFVWNHNEQYTu1U6c1ncWpcRJa9A1k6m2kdxNO9Mle3rfyBbiwgIlsqA65/z
         bx2v+p5RlBItOcybeCWK3kn8P1rKcG37ir+MlgrgVDeH8gcp1Qdr5FgysGJK6mm1ADe1
         N+aHk9TFAX+ixHJIMoS6apeBr+EdYs5gfV9uZFLrRnJBAnnQArETJRZWeNQ9lSTX8I5u
         TiSH6STWWsUuMeicdW4x71H3KyXOuOwRdJP4nz7XZImmxUJneSf7jRa03DKSlBuDSsOe
         x6EKmQQ0UgyYyjydXQIqvFAsYrviU0tleUe6LmhHibmMZd90ePOA3R9+sT79Qdzthc93
         LxVA==
X-Received: by 10.15.43.10 with SMTP id w10mr29251686eev.13.1387372220673;
        Wed, 18 Dec 2013 05:10:20 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id n1sm62403127eep.20.2013.12.18.05.10.18
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 05:10:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131209234500.GY29959@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239430>

Am 10.12.2013 00:45, schrieb Jonathan Nieder:
> Karsten Blees wrote:
> 
>> Googling some more, I believe the most protable way to achieve this
>> via 'compiler settings' is
>>
>>  #pragma pack(push)
>>  #pragma pack(4)
>>  struct hashmap_entry {
>>    struct hashmap_entry *next;
>>    unsigned int hash;
>>  };
>>  #pragma pack(pop)
>>
>> This is supported by at least GCC, MSVC and HP (see your link). The
>> downside is that we cannot use macros (in git-compat-util.h) to emit
>> #pragmas. But we wouldn't have to, as compilers aren't supposed to
>> barf on unknown #pragmas.
> 
> Technically this can be done using macros:
> 
>  #if (gcc)
>  #	define BEGIN_PACKED _Pragma("pack(push,4)")
>  #	define END_PACKED _Pragma("pack(pop)")
>  #elif (msvc)
>  #	define BEGIN_PACKED __pragma(pack(push,4))
>  #	define END_PACKED __pragma(pack(pop))
>  #else
>  	/* Just tolerate a little padding. */
>  #	define BEGIN_PACKED
>  #	define END_PACKED
>  #end
> 
> Then you can do:
> 
>  BEGIN_PACKED
>  struct hashmap_entry {
>  	...
>  };
>  END_PACKED
> 

Sorry for the delay...

My intention with #pragma pack was to support as many compilers / platforms as possible (even though I can't test them all). From what I could find on the 'net, support for the _Pragma operator is slim. And as the MSVC build is 32-bit only (AFAIK), this is pretty much a GCC-only solution (and thus equivalent, but much more verbose than the initial __attribute__((__packed__)) variant).

> Whether that's nicer or uglier than the alternatives I leave to you.
> ;-)

If it was really up to me ( :-) ), I'd like to do this:

------ 8< -------
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
index f5183fb..2d5a63a 100644
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
+				       sizeof(struct pointer_int),
+				       sizeof(void *));
+
 		} else if (!strcmp("perfhashmap", cmd) && l1 && l2) {
 
 			perf_hashmap(atoi(p1), atoi(p2));
-- 
1.8.5.1.276.g562b27a
