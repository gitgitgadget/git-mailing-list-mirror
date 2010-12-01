From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] parse-options: sanity check PARSE_OPT_NOARG flag
Date: Wed, 1 Dec 2010 17:30:20 -0600
Message-ID: <20101201233020.GE31815@burratino>
References: <20101201232728.GA31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:30:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNw8C-0001UM-3O
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab0LAXaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 18:30:30 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61916 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0LAXaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:30:30 -0500
Received: by qyk12 with SMTP id 12so9622823qyk.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 15:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EpI/59QUD0MS2iUc3XYr84N70SkHbPoRAd2iJVKN9tM=;
        b=iwRVqQCEzM50z/WYsGqUHszmKGn0mzqXKfm6XPDKVLLgLiBXQAy2P3Jj5JGL3Pu2wh
         aRfsenU/0O0T5LxEcmx5+7azf4htCfinpm2mpKqEsIlwf9t2rlZ6ffndJ5P1ppv2Z3VE
         El9tj8wQDVqW7RGL6w9Rwa6DCjm4yxJHAvOYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=noQ+Vxlvj1Uj79os7PK/u0UUwUGtdLB4AqTWo3pT7q1Vap2Pyf5hosn674lRwmNwuD
         gpsU/1rpdK80X9SldEJXUZtKr8FsuSeYnMMeSzdOzJstL85Gd14L7FvHKEHUUsGjSkE/
         bKK2smZEmNHmY5sI93phQDtyOBJDi9F8l+BEk=
Received: by 10.229.229.135 with SMTP id ji7mr7767245qcb.100.1291246229078;
        Wed, 01 Dec 2010 15:30:29 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l14sm350495qck.29.2010.12.01.15.30.27
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 15:30:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101201232728.GA31815@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162642>

Some option types cannot use an argument --- boolean options that
would set a bit or flag or increment a counter, for example.  If
configured in the flag word to accept an argument anyway, the result
is an argument that is advertised in "program -h" output only to be
rejected by parse-options::get_value.

Luckily all current users of these option types use PARSE_OPT_NOARG
and do not use PARSE_OPT_OPTARG.  Add a check to ensure that that
remains true.  The check is run once for each invocation of
parse_option_start().

Improved-by: Stephen Boyd <bebarino@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 parse-options.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index c825620..e4d0b82 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -328,6 +328,19 @@ static void parse_options_check(const struct option *opts)
 		     opts->long_name))
 			optbug(opts, "uses feature "
 				"not supported for dashless options");
+		switch (opts->type) {
+		case OPTION_BOOLEAN:
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_SET_INT:
+		case OPTION_SET_PTR:
+		case OPTION_NUMBER:
+			if ((opts->flags & PARSE_OPT_OPTARG) ||
+			    !(opts->flags & PARSE_OPT_NOARG))
+				optbug(opts, "should not accept an argument");
+		default:
+			; /* ok. (usually accepts an argument) */
+		}
 	}
 }
 
-- 
1.7.2.3
