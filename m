From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP redirection with git-clone/git-fetch ?
Date: Wed, 9 Nov 2005 16:24:20 -0800
Message-ID: <20051110002419.GB4051@reactrix.com>
References: <200511092331.36421.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 01:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea0Fn-0005Ps-RY
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 01:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKJAZV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 19:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbVKJAZU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 19:25:20 -0500
Received: from 195.37.26.69.virtela.com ([69.26.37.195]:54845 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1751107AbVKJAZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 19:25:19 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAA0OU8v013693;
	Wed, 9 Nov 2005 16:24:45 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAA0OKFU013687;
	Wed, 9 Nov 2005 16:24:20 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200511092331.36421.Josef.Weidendorfer@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11453>

On Wed, Nov 09, 2005 at 11:31:36PM +0100, Josef Weidendorfer wrote:

> This seems because git-fetch should understand redirections, too.
> I am not familiar to the curl API. So perhaps another one can try to
> fix this?

This should fix it, although it still tries every GET with the original
URL which is a bit inefficient.


Configure HTTP fetch to follow redirects

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 git-fetch.sh |    2 +-
 http-fetch.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

applies-to: bc694e972ad9e82f65359788db6ef788078a975f
deb8d58781a60d4611651478c5b08739edf981b7
diff --git a/git-fetch.sh b/git-fetch.sh
index 31e5f4c..8564cbf 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -230,7 +230,7 @@ do
 	    $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
 	    print "$u";
 	' "$remote_name")
-	head=$(curl -nsf $curl_extra_args "$remote/$remote_name_quoted") &&
+	head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
 	expr "$head" : "$_x40\$" >/dev/null ||
 		die "Failed to fetch $remote_name from $remote"
 	echo >&2 Fetching "$remote_name from $remote" using http
diff --git a/http-fetch.c b/http-fetch.c
index ea8af1b..28d225c 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -269,6 +269,8 @@ static CURL* get_curl_handle(void)
 				 curl_low_speed_time);
 	}
 
+	curl_easy_setopt(result, CURLOPT_FOLLOWLOCATION, 1);
+
 	return result;
 }
 
---
0.99.9.GIT
