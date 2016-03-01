From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 06/10] setup: refactor repo format reading and
 verification
Date: Tue, 01 Mar 2016 16:20:06 -0500
Organization: Twitter
Message-ID: <1456867206.18017.94.camel@twopensource.com>
References: <20160301143546.GA30806@sigill.intra.peff.net>
	 <20160301144206.GF12887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 22:20:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aariP-0000tT-AO
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 22:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbcCAVUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 16:20:12 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35961 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbcCAVUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 16:20:09 -0500
Received: by mail-qg0-f50.google.com with SMTP id u110so24222860qge.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 13:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=w9BkYMbyUMFr35TzvDCbzOwqNMUEAgsXeTrExZ3HhCU=;
        b=iMCVi7+j8z5qtKq2lHu+SE+urFy3zkOWRtysXEdpmMTB4+rtrCsgkqodf9ZgsYW+h5
         SVQOiSzy//rx0U9zpiPNsduWyAvWfvjCK+h1Ss5I0s+RBXJESfrgAtEgpwDIoL6XDTTw
         NJirLTNgkrvnAzvZf8kkZL7cFTgNN+UVceeSRAoTdkojPAQglvDoTEg5xDR86T9PpFAG
         WGBCbWwT8IYNPIk/K16QnH5zbQwL5I4yYsU9tWh/PRMJbCPTBU6dypWLF+SijBIcfVXb
         hqbMPUm1SxVYyo8ryCBqLYrVwT8bRUeJacDh4ktwz8RkGKo3UogD+meGeG+Q5m84L4xs
         KbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=w9BkYMbyUMFr35TzvDCbzOwqNMUEAgsXeTrExZ3HhCU=;
        b=HU5U6XYEyF5MZ+DSTya+c5p289LOEjKbPs9CKY1BLGZwwDWl8W+r8eG8uxv4z5gDPr
         XvQKUNjQ99UUz+F+7QT/WEgrwKRPKBTwIV5KFikRXHHf5CcAbM444cdfcyi8drJUbKgy
         oTd6IBeIfq0ZDOgCSWcy6R1VNSW3OwtIqpQe0Dc4pGI2pRLFzRIwk2RDqAuRktNnY9W4
         QXu9+rdVE63jroSb8Z+Flzbz5yE4S5i8oSfAQHi20sJyxe0kkCMutX2k5hS2TSt76dFO
         oG584COi+t3rp9erJdDwY8sPEGRvlYBghtnVrH0VVRnNvYMmzNX3XHajGK/kuwUJ8X1G
         30sQ==
X-Gm-Message-State: AD7BkJLIe6u3ClIxUrB+Kc2zKrmOEHx98yrWu+BVA2LD7Xo7ji44W585diJSUygQbuk3Cg==
X-Received: by 10.140.156.212 with SMTP id c203mr31050088qhc.96.1456867208278;
        Tue, 01 Mar 2016 13:20:08 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w70sm13710742qge.13.2016.03.01.13.20.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 13:20:06 -0800 (PST)
In-Reply-To: <20160301144206.GF12887@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288065>

On Tue, 2016-03-01 at 09:42 -0500, Jeff King wrote:
> +/*
> + * Read the repository format characteristics from the config file
> "path". If
> + * the version cannot be extracted from the file for any reason, the
> version
> + * field will be set to -1, and all other fields are undefined.
> + */
> +void read_repository_format(struct repository_format *format, const
> char *path);

Generally speaking, I don't care for this interface; I would prefer to
return -1 and not change the struct.  But I see why it's maybe simpler
in this one case.

+/*
> + * Internally, we need to swap out "fn" here, but we don't want to
> expose
> + * that to the world. Hence a wrapper around this internal function.
> + */

I don't understand this comment.  fn is not being swapped out -- it's
being passed on directly.  

> +static void read_repository_format_1(struct repository_format
> *format,
> +				     config_fn_t fn, const char
> *path)

The argument order here is different from git_config_from_file -- is
that for a reason?

> +	if (format->version >= 1 && format->unknown_extensions.nr) {
> +		int i;
> +
> +		for (i = 0; i < format->unknown_extensions.nr; i++)
> +			strbuf_addf(err, "unknown repository
> extension: %s",
> +				    format
> ->unknown_extensions.items[i].string);

newline here or something?  Otherwise multiple unknown extensions will
get jammed together.
