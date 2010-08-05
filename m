From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/12] merge-trees: let caller decide whether to renormalize
Date: Thu, 5 Aug 2010 06:15:32 -0500
Message-ID: <20100805111532.GG13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyRg-0003cD-Rt
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859Ab0HELRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:17:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36794 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360Ab0HELRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:17:01 -0400
Received: by iwn33 with SMTP id 33so83224iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=AtgpnErPgHZXHbcR8WFDFLEi2BWPBp6gZEGC1yuUleg=;
        b=d5HATeVejCjRaiunQH0AnKIVgAEf0H2t9y9fkHM2LvwxlVM/JhlOOgxRV0V/qcy2hi
         xAMsCTJfgAXbHI2c9mAFLpWdvlCGIP65K7yQJ8YhSlJcAf9LnZdUkNHPopMvT27VNn7s
         Kr/6CuiVYukCcrhjqXwqVuwBH+kw7EJEv271I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vGJ5fKaTgVJgmt88+tQzS1tITPaBFTQuxklhlBaikkb9BV67vpsdJ5NliV4V2qZ3D0
         klat6fprMl0h/pRRTmoTDIRt1+yGCHf8wPJM7wLOtYIQ6bFK0nmpStjjyXy4jTtT2hic
         +KMQ2MspL3OlAm5BjOgy523CUzI97fGtRu9WM=
Received: by 10.231.33.67 with SMTP id g3mr12077325ibd.31.1281007017851;
        Thu, 05 Aug 2010 04:16:57 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm44895ibh.22.2010.08.05.04.16.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:16:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152637>

Add a "renormalize" option to struct merge_options so callers can
decide on a case-by-case basis whether the merge is likely to have
overlapped with a change in smudge/clean rules.  The option defaults
to the global merge_renormalize setting for now.

No change in behavior intended.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The renormalize option now is advertized to only require one bit.
Maybe some optimizer will take advantage of that.

 merge-recursive.c |    3 ++-
 merge-recursive.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 2b55fc2..8a49844 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1112,7 +1112,7 @@ static int process_entry(struct merge_options *o,
 	print_index_entry("\tpath: ", entry);
 	*/
 	int clean_merge = 1;
-	int normalize = merge_renormalize;
+	int normalize = o->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
 	unsigned b_mode = entry->stages[3].mode;
@@ -1484,6 +1484,7 @@ void init_merge_options(struct merge_options *o)
 	o->buffer_output = 1;
 	o->diff_rename_limit = -1;
 	o->merge_rename_limit = -1;
+	o->renormalize = merge_renormalize;
 	git_config(merge_recursive_config, o);
 	if (getenv("GIT_MERGE_VERBOSITY"))
 		o->verbosity =
diff --git a/merge-recursive.h b/merge-recursive.h
index b831293..c5fbe79 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -14,6 +14,7 @@ struct merge_options {
 	} recursive_variant;
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
+	unsigned renormalize : 1;
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
-- 
1.7.2.1.544.ga752d.dirty
