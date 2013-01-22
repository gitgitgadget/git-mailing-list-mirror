From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3] Enable minimal stat checking
Date: Tue, 22 Jan 2013 18:19:16 +0100
Message-ID: <50FECA14.5030802@web.de>
References: <7v4niblhr6.fsf@alter.siamese.dyndns.org> <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	j sixt <j.sixt@viscovery.net>,
	Shawn Pearce <spearce@spearce.org>,
	=?ISO-8859-1?Q?Torsten_B=F6gershau?= =?ISO-8859-1?Q?sen?= 
	<tboegi@web.de>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxhVg-00014U-9y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 18:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab3AVRTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 12:19:23 -0500
Received: from mout.web.de ([212.227.17.12]:50931 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab3AVRTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 12:19:22 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LuMER-1SwYuA2jod-0118GJ; Tue, 22 Jan 2013 18:19:17
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <1358840962-12316-1-git-send-email-robin.rosenberg@dewire.com>
X-Provags-ID: V02:K0:27Di+vZFbeZLwvzM3/j5x73xI+KAb6J3OuZKrf/ccw7
 EH1FJ+vxcaGoVFy3qod3r/Z2ghKdIqcxfMzNWiSdzLjFwo8XzV
 kzv4lFQIUr285hQFpK/yF6+QkYFu2TlCDTmdt2b6d0jtEhRt+q
 U0eWR98wgh+O8yQeTfeKlAgyYSwqhQUNAz2oka32I0ymLAzGW1
 nNpXhj9nrm58H+A3gpBkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214239>


+core.checkstat::
+	Determines which stat fields to match between the index
+	and work tree. The user can set this to 'default' or
+	'minimal'. Default (or explicitly 'default'), is to check
+	all fields, including the sub-second part of mtime and ctime.
+
Setting 'minimal' implies core.trustctime = false

[snip]

> -	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> -		changed |= CTIME_CHANGED;
> +	if (trust_ctime ? check_stat : trust_ctime/*false*/)
> +		if (ce->ce_ctime.sec != (unsigned int)st->st_ctime)
> +			changed |= CTIME_CHANGED;

Could that be written as:
+	if (trust_ctime && check_stat && (ce->ce_ctime.sec != (unsigned int)st->st_ctime))
+			changed |= CTIME_CHANGED;


>  
>  #ifdef USE_NSEC
> -	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
> +	if (check_stat && ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
>  		changed |= MTIME_CHANGED;
> -	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
> -		changed |= CTIME_CHANGED;
> +	if (trust_ctime ? check_stat : trust_ctime/*false*/)
> +		if (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
> +			changed |= CTIME_CHANGED;

And here:
+	if (trust_ctime && check_stat && (ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+		changed |= CTIME_CHANGED;
