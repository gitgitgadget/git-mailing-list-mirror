From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Mon, 05 Oct 2015 21:24:04 -0400
Organization: Twitter
Message-ID: <1444094644.7739.20.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-39-git-send-email-dturner@twopensource.com>
	 <56123CE3.9070909@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 06 03:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjGzF-0005Ub-IG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 03:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbJFBYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 21:24:08 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36659 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbJFBYH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 21:24:07 -0400
Received: by qgx61 with SMTP id 61so166128312qgx.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 18:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vdlOfMcuc+X4GZb7y4PUnh6OLF46CjJsIyi+uSH5rqg=;
        b=KK2Lcx9TmZ9IKaduTc3nX0zTAi821lrQEhAfUsYNdcWfXbAXxDS5v9W4r8AY7Kv8kb
         a1rs6GmYQNo4o/oe+0b9hZTHOhkWRQ/6TuoUIsih77zqZXok4UmlNYrk2nEWZqPVELtt
         W7k/EC9qnXM10Mm6VDxMGwlI/5nuZz6bUEZAai2GRNuLqrR4iVPRfl43deSxlANEuUyr
         J+XnuOE+FTm+yK1yJhT6nwSlp1T4We0YARVGfe8AvHdIGMAs1y91G+ghgsh9KUdVuWDr
         xnTebOypZ9qUUt+ULuO+twdcMwJHEzDkdLnvObdI0phQ+X9C7ovINS8c/7mUTpwftbwh
         CiUw==
X-Gm-Message-State: ALoCoQmmv9x95V6YAXSiAbrtXj6uNweVEq2/Coj/lvqyT1UF9I14jFgT8rUSrixLtPJbvzUKT0Xj
X-Received: by 10.140.109.74 with SMTP id k68mr44370147qgf.77.1444094645956;
        Mon, 05 Oct 2015 18:24:05 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id s12sm12725390qkl.2.2015.10.05.18.24.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 18:24:05 -0700 (PDT)
In-Reply-To: <56123CE3.9070909@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279110>

On Mon, 2015-10-05 at 11:03 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > Because HEAD and stash are per-worktree, other backends need to
> > go through the files backend to manage these refs and their reflogs.
> > 
> > To enable this, we make some files backend functions public.
> 
> I have a bad feeling about this change.
> 
> Naively I would expect a reference backend that cannot handle its own
> (e.g.) stash to instantiate internally a files backend object and to
> delegate stash-related calls to that object. That way neither class's
> interface has to be changed.
> 
> Here you are adding a separate interface to the files backend. That
> seems like a more complicated and less flexible design. But I'm open to
> be persuaded otherwise...

OK, I've switched over most of these to use an internal files backend.

While doing so, I thought I needed to keep files_log_ref_write, 
because we need to  handle refs that cross over between the lmdb 
backend and the files backend.

But on reflection, I have realized that I'm doing cross-backend refs 
wrong anyway (I'm prematurely committing the files backend ones, and
doing it without locks).  So I think I need to rethink this a bit. 
Probably I can split out a files transaction using REF_NODEREF or 
something.

Will do something about this.
