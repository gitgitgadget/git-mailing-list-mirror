From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 20:11:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Adrian Bunk <bunk@stusta.de>
X-From: git-owner@vger.kernel.org Wed Sep 27 05:15:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPt2-0001Du-Bm
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWI0DPA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWI0DPA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:15:00 -0400
Received: from mx3.cs.washington.edu ([128.208.3.132]:57797 "EHLO
	mx3.cs.washington.edu") by vger.kernel.org with ESMTP
	id S932338AbWI0DO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 23:14:59 -0400
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [128.208.1.140])
	by mx3.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8R3BW58025839
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Sep 2006 20:11:32 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8R3BWFD001398;
	Tue, 26 Sep 2006 20:11:32 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27864>

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> @@ -574,10 +585,11 @@ static void show_graph(char ch, int cnt,
>  static void show_stats(struct diffstat_t* data, struct diff_options *options)
>  {
>  	int i, len, add, del, total, adds = 0, dels = 0;
> -	int max_change = 0, max_len = 0;
> +	int max_change = 0, max_len = 0, min_change = 0;
>  	int total_files = data->nr;
>  	int width, name_width;
>  	const char *reset, *set, *add_c, *del_c;
> +	int non_linear_scale = 0;
>  
>  	if (data->nr == 0)
>  		return;
> @@ -620,6 +632,8 @@ static void show_stats(struct diffstat_t
>  			continue;
>  		if (max_change < change)
>  			max_change = change;
> +		if (0 < change && (!min_change || change < min_change))
> +			min_change = change;
>  	}

Again with the constant placement in a comparison expression.

> @@ -684,6 +704,11 @@ static void show_stats(struct diffstat_t
>  
>  		if (max_change < width)
>  			;
> +		else if (non_linear_scale) {
> +			total = scale_non_linear(total, width, max_change);
> +			add = scale_linear(add, total, add + del);
> +			del = total - add;
> +		}
>  		else {
>  			total = scale_linear(total, width, max_change);
>  			add = scale_linear(add, width, max_change);
> 

if (...)
	;
else if {
	...
}

is _never_ necessary.

		David
