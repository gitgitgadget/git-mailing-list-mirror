From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v1.7.4-rc2] ll-merge: simplify opts == NULL case
Date: Sat, 15 Jan 2011 19:08:42 -0600
Message-ID: <20110116010841.GA18049@burratino>
References: <20100823205915.GA4484@ns1.cockos.com>
 <20100826054158.GB9708@burratino>
 <20100826054953.GE9708@burratino>
 <7vpqx5mipt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 16 02:09:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PeH7O-0005ze-BZ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Jan 2011 02:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab1APBJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 20:09:02 -0500
Received: from mail-yi0-f42.google.com ([209.85.218.42]:38550 "EHLO
	mail-yi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab1APBJA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 20:09:00 -0500
Received: by yia28 with SMTP id 28so2062080yia.1
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 17:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vY7lKJQXcK3uhruT1beqZ/a/4Q9sck+Lavv4QwlKI6I=;
        b=aLXsI/OG4kQJuVY0HNdqws6MetrAkxTdUi6WgzqOCXeOsu4P74xPhFfMi7bC52snMz
         DwZ4lGMBUxN70x5i+vc3RTR3Y+PGeUn0IZ08Ew6k5NHs//k+UiUJHPXf3+4GLwOmIOgj
         SXv+qOApdnCA1T+WjkhfVE1a8bE+SHY4FXtU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mmxZqxCMH3mOIk2GJ83p7/Dt/VzbLRJ9/7Ijs1WBbFH8So9XDTkuZgbasjwgofWVSR
         9SkiKzplCrXxxgDf/S30PoDOWnBsjyD7EFxdTsd40u7iCByYw/oyV5XCtbJ5+eqj4BLX
         luL14zHMk3QEBIiTlzILdM63Er13Q1liuUgAI=
Received: by 10.150.216.3 with SMTP id o3mr2937896ybg.281.1295140139879;
        Sat, 15 Jan 2011 17:08:59 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id q33sm1780925yba.19.2011.01.15.17.08.54
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 15 Jan 2011 17:08:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vpqx5mipt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165149>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +	if (!opts) {
>> +		struct ll_merge_options default_opts = {0};
>> +		return ll_merge(result_buf, path, ancestor, ancestor_label,
>> +				ours, our_label, theirs, their_label,
>> +				&default_opts);
>
> Fun---expecting tail recursion elimination ;-)?

Fun but not warranted.  Let's simplify.

-- 8< --
Subject: ll-merge: simplify opts == NULL case

As long as sizeof(struct ll_merge_options) is small, there is not
much reason not to keep a copy of the default merge options in the BSS
section.  In return, we get clearer code and one less stack frame in
the opts == NULL case.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ll-merge.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 007dd3e..6ce512e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -351,16 +351,13 @@ int ll_merge(mmbuffer_t *result_buf,
 	     const struct ll_merge_options *opts)
 {
 	static struct git_attr_check check[2];
+	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
 
-	if (!opts) {
-		struct ll_merge_options default_opts = {0};
-		return ll_merge(result_buf, path, ancestor, ancestor_label,
-				ours, our_label, theirs, their_label,
-				&default_opts);
-	}
+	if (!opts)
+		opts = &default_opts;
 
 	if (opts->renormalize) {
 		normalize_file(ancestor, path);
-- 
1.7.4.rc2
