From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Subject: Re: [PATCH 12/12] Optimize diff-tree -[CM] --stdin
Date: Sat, 4 Jun 2005 11:17:55 +0900
Message-ID: <20050604111755.50a34338.yuasa@hh.iij4u.or.jp>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7vhdgo2s7t.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: yuasa@hh.iij4u.or.jp, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 04:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeOBj-0005xN-01
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 04:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFDCSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 22:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFDCSS
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 22:18:18 -0400
Received: from mo01.iij4u.or.jp ([210.130.0.20]:17662 "EHLO mo01.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261225AbVFDCSM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 22:18:12 -0400
Received: MO(mo01)id j542I3h4014087; Sat, 4 Jun 2005 11:18:03 +0900 (JST)
Received: MDO(mdo01) id j542I3hZ018545; Sat, 4 Jun 2005 11:18:03 +0900 (JST)
Received: from stratos (h042.p502.iij4u.or.jp [210.149.246.42])
	by mbox.iij4u.or.jp (4U-MR/mbox01) id j542I2ns007703
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NOT);
	Sat, 4 Jun 2005 11:18:02 +0900 (JST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdgo2s7t.fsf_-_@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 27 May 2005 15:56:38 -0700
Junio C Hamano <junkio@cox.net> wrote:

>

<snip>

> diff --git a/diff.c b/diff.c
> --- a/diff.c
> +++ b/diff.c
> @@ -12,6 +12,7 @@ static const char *diff_opts = "-pu";
>  static unsigned char null_sha1[20] = { 0, };
>  
>  static int reverse_diff;
> +static int use_size_cache;
>  
>  static const char *external_diff(void)
>  {
> @@ -222,12 +223,60 @@ static int work_tree_matches(const char 
>  	return 1;
>  }
>  
> +static struct sha1_size_cache {
> +	unsigned char sha1[20];
> +	unsigned long size;
> +} **sha1_size_cache;
> +static int sha1_size_cache_nr, sha1_size_cache_alloc;
> +
> +static struct sha1_size_cache *locate_size_cache(unsigned char *sha1,
> +						 unsigned long size)
> +{
> +	int first, last;
> +	struct sha1_size_cache *e;
> +
> +	first = 0;
> +	last = sha1_size_cache_nr;
> +	while (last > first) {
> +		int next = (last + first) >> 1;
> +		e = sha1_size_cache[next];
> +		int cmp = memcmp(e->sha1, sha1, 20);

I got build error in diff.c
Please apply the following patch.

Thanks,

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -244,9 +244,9 @@ static struct sha1_size_cache *locate_si
 	first = 0;
 	last = sha1_size_cache_nr;
 	while (last > first) {
-		int next = (last + first) >> 1;
+		int cmp, next = (last + first) >> 1;
 		e = sha1_size_cache[next];
-		int cmp = memcmp(e->sha1, sha1, 20);
+		cmp = memcmp(e->sha1, sha1, 20);
 		if (!cmp)
 			return e;
 		if (cmp < 0) {
