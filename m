From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Tue, 22 Oct 2013 16:32:58 -0700
Message-ID: <20131022233257.GA9464@google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
 <20131011235052.GV9464@google.com>
 <20131012002639.GE79408@vauxhall.crustytoothpaste.net>
 <20131018221535.GM865149@vauxhall.crustytoothpaste.net>
 <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 01:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYlRk-0000rp-94
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 01:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774Ab3JVXdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 19:33:03 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:60206 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3JVXdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 19:33:02 -0400
Received: by mail-pb0-f42.google.com with SMTP id jt11so40327pbb.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 16:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vv9/dtaG3qYJ+/ujZU2qKIEiVrcxxyvWVa4Km0yG9G4=;
        b=Wl7T0vObNcPOwlfMGlw58uxHMk+AsHP3DQC4423qCXC8rNZYSyYPbAoNHVDyq/D/I4
         9g28DWAhHz9+liUrZOehXWb0mG3MkclzOHL4Dwqzy8EV4G1PVzI6lVFkiiY9B/zVwqea
         qjn6bv9mQdLSAGH2D1Mnj53/NB4IS97daF3CauYjQcoAaiYxY6yxwCYCoMr0rV2lvDTG
         6MM4BCF5h6x6Mam1WVfd65VGPb4ftsMpT37+cyAjIvTi8AhqXGLeqvl7C8XqqG2ygEd1
         7F9YhUMywoP9U80sAiZ6xV3uXrtyiO3C1OXYFTNot308RdA762xKHNJQQOD4RxQVOv5q
         DfOA==
X-Received: by 10.66.156.9 with SMTP id wa9mr148455pab.151.1382484780871;
        Tue, 22 Oct 2013 16:33:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y9sm36372898pas.10.2013.10.22.16.32.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Oct 2013 16:33:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqeh7csygy.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236493>

Junio C Hamano wrote:

>     +http.continue::
>     +	Ensure that authentication succeeds before sending the pack data when
>     +	POSTing data using the smart HTTP transport.

I think we always do that (since v1.7.5-rc0~82^2~1, "smart-http: Don't
use Expect: 100-Continue", 2011-02-15), in probe_rpc().

This series seems to be instead about ensuring that authentication
succeeds before proceding, within the same connection.  The commit
message doesn't mention this, but the symptom being addressed is the
following:

	$ git push https://bmc@git.crustytoothpaste.net/git/bmc/test.git development
	Counting objects: 37994, done.
	Delta compression using up to 4 threads.
	Compressing objects: 100% (10683/10683), done.
	Writing objects: 100% (37994/37994), 9.15 MiB | 4.45 MiB/s, done.
	Total 37994 (delta 26760), reused 37633 (delta 26467)
	Unable to rewind rpc post data - try increasing http.postBuffer
	Password for 'https://bmc@git.crustytoothpaste.net': 

As Brian explains:

	GSS-Negotiate authentication always requires a rewind with cURL.

While reviewing patch 1/2, this workaround seemed like a good idea to
me --- it lets GSS-Negotiate authentication work without harming
current users.  But after reviewing patch 2/2, it seems that there is
no good value to set this option to (I don't mean no good *default*
value, but no good value at all).  That tells me that either the
documentation needs improvement or this is the wrong knob to make
configurable.

The problem:

 a) If I set "[http] use100Continue" to true, then I can use
    GSS-Negotiate authentication without running into the problem of
    not being able to rewind.  But when I try to use code.google.com
    it will hang for a second while it waits for the 100-continue.

 b) If I set "[http] use100Continue" to false, then I can access
    code.google.com without any 1-second delays.  But I cannot perform
    large pushes using GSS-Negotiate authentication without increasing
    http.postBuffer.

Wouldn't a natural fix be to *always* use "Expect: 100-continue" when
and only when the probe_rpc() revealed a server supporting
GSS-Negotiate authentication?
