From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Show total transferred as part of throughput progress
 display
Date: Thu, 01 Nov 2007 10:18:49 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711010814140.21255@xanadu.home>
References: <20071101035704.GA4518@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inasz-0007b7-BJ
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbXKAOSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbXKAOSv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:18:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37831 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXKAOSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:18:51 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQT006CVZRDAE70@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 01 Nov 2007 10:18:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071101035704.GA4518@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62962>

On Wed, 31 Oct 2007, Shawn O. Pearce wrote:

> We now show the total amount of data we have transferred over
> the network as part of the throughput meter, organizing it in
> "human friendly" terms like `ls -h` would do.  Users can glance at
> this, see that the total transferred size is about 3 MiB, see the
> throughput of X KiB/sec, and determine a reasonable figure of about
> when the clone will be complete, assuming they know the rough size
> of the source repository or are able to obtain it.

Well, OK.  But...

> This is also a helpful indicator that there is progress being made
> even if we stall on a very large object.  The thoughput meter may
> remain relatively constant and the percentage complete and object
> count won't be changing, but the total transferred will be increasing
> as additional data is received for this object.

Currently if the object count is unchanged for an extended period of 
time, the display_progress() function isn't called at all, so the 
updated byte count (and rate) won't be displayed either.  This needs a 
fix, probably in a separate patch which I'll send right away.

> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

Well, your patch has issues. Please see comments below.

> diff --git a/progress.c b/progress.c
> index 23ee9f3..5c95091 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -11,7 +11,11 @@ struct throughput {
>  	unsigned int avg_misecs;
>  	unsigned int last_misecs[TP_IDX_MAX];
>  	unsigned int idx;
> -	char display[20];
> +	unsigned int unit_size;
> +	unsigned int unit_index;
> +	unsigned int total_units;
> +	unsigned int curr_bytes;
> +	char display[40];
>  };
>  
>  struct progress {
> @@ -24,6 +28,7 @@ struct progress {
>  	struct throughput *throughput;
>  };
>  
> +static const char *units[] = {"bytes", "KiB", "MiB", "GiB"};
>  static volatile sig_atomic_t progress_update;
>  
>  static void progress_interval(int signum)
> @@ -113,12 +118,27 @@ void display_throughput(struct progress *progress, unsigned long n)
>  
>  	if (!tp) {
>  		progress->throughput = tp = calloc(1, sizeof(*tp));
> -		if (tp)
> +		if (tp) {
>  			tp->prev_tv = tv;
> +			tp->unit_size = 1;
> +		}
>  		return;
>  	}
>  
>  	tp->count += n;
> +	tp->curr_bytes += n;
> +	if (tp->curr_bytes > tp->unit_size) {
> +		tp->total_units += tp->curr_bytes / tp->unit_size;
> +		tp->curr_bytes = tp->curr_bytes % tp->unit_size;
> +
> +		while (tp->total_units >= 1024
> +			&& tp->unit_index < ARRAY_SIZE(units)) {
> +			tp->curr_bytes += (tp->total_units % 1024) * tp->unit_size;
> +			tp->total_units = tp->total_units / 1024;
> +			tp->unit_size *= 1024;
> +			tp->unit_index++;
> +		}
> +	}

This whole block could be moved inside the "if (misecs > 512)" 
conditional.  There is no point performing that computation over and 
over when the display isn't updated more than twice a second anyway.

> @@ -143,7 +163,13 @@ void display_throughput(struct progress *progress, unsigned long n)
>  		tp->avg_bytes += tp->count;
>  		tp->avg_misecs += misecs;
>  		snprintf(tp->display, sizeof(tp->display),
> -			 ", %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
> +			 ", %3u.%2.2u %s     %lu KiB/s",

The line is becoming quite long already, and I'd prefer if remote 
messages like the pack-objects summary kept overwriting it entirely 
while this line is bumped to the next line on screen for a prettier 
display.  So I'd prefer if there wasn't so many spaces inserted there.  
What about something like ", %u.%2.2u %s | %lu KiB/s" instead?

Also I think that displaying fractional bytes, even if it is always 0, 
is a bit weird.

> +			 tp->total_units,
> +			 tp->unit_size > 1
> +				? tp->curr_bytes / (tp->unit_size / 100)

This has integer truncation problems.  Suppose tp->unit_size = 1024 and
tp->curr_bytes = 1023.  You get 1023 / (1024 / 100) = 102 while the
desired result should be 99.

Overall I think your patch is also needlessly too complex.
this could be implemented in a much simpler way, such as follows:

diff --git a/progress.c b/progress.c
index 34a5961..1212be8 100644
--- a/progress.c
+++ b/progress.c
@@ -15,13 +15,14 @@
 
 struct throughput {
 	struct timeval prev_tv;
+	size_t total;
 	unsigned long count;
 	unsigned long avg_bytes;
 	unsigned long last_bytes[TP_IDX_MAX];
 	unsigned int avg_misecs;
 	unsigned int last_misecs[TP_IDX_MAX];
 	unsigned int idx;
-	char display[20];
+	char display[32];
 };
 
 struct progress {
@@ -128,6 +129,7 @@ void display_throughput(struct progress *progress, unsigned long n)
 		return;
 	}
 
+	tp->total += n;
 	tp->count += n;
 
 	/*
@@ -149,11 +151,32 @@ void display_throughput(struct progress *progress, unsigned long n)
 	misecs += (int)(tv.tv_usec - tp->prev_tv.tv_usec) / 977;
 
 	if (misecs > 512) {
+		unsigned l = sizeof(tp->display);
 		tp->prev_tv = tv;
 		tp->avg_bytes += tp->count;
 		tp->avg_misecs += misecs;
-		snprintf(tp->display, sizeof(tp->display),
-			 ", %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+
+		if (tp->total > 1 << 30) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u GiB",
+				      (int)(tp->total >> 30),
+				      (int)(tp->total & ((1 << 30) - 1)) / 10737419);
+		} else if (tp->total > 1 << 20) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u MiB",
+				      (int)(tp->total >> 20),
+				      ((int)(tp->total & ((1 << 20) - 1))
+				       * 100) >> 20);
+		} else if (tp->total > 1 << 10) {
+			l -= snprintf(tp->display, l, ", %u.%2.2u KiB",
+				      (int)(tp->total >> 10),
+				      ((int)(tp->total & ((1 << 10) - 1))
+				       * 100) >> 10);
+		} else {
+			l -= snprintf(tp->display, l, ", %u bytes",
+				      (int)tp->total);
+		}
+		snprintf(tp->display + sizeof(tp->display) - l, l,
+			 " | %lu KiB/s", tp->avg_bytes / tp->avg_misecs);
+
 		tp->avg_bytes -= tp->last_bytes[tp->idx];
 		tp->avg_misecs -= tp->last_misecs[tp->idx];
 		tp->last_bytes[tp->idx] = tp->count;

Nicolas
