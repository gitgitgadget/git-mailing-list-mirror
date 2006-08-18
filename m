From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Thu, 17 Aug 2006 23:12:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri Aug 18 08:12:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDxad-0005IX-0f
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 08:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWHRGMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 02:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWHRGMN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 02:12:13 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45048 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750983AbWHRGMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 02:12:12 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7I6C6rQ013473
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:12:06 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=Eu/0aHH6QcThdTAoxnet8biWfBRD4npfKJ+laInQKRQbK0kb4rem6Zq/3YKA3Px12
	HkacCdZTFDCtu8n8vAlnA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7I6C2nl027080
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:12:02 -0700
Received: by localhost (Postfix, from userid 24081)
	id 7B5FF87D71; Thu, 17 Aug 2006 23:12:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 40DA587D70
	for <git@vger.kernel.org>; Thu, 17 Aug 2006 23:12:02 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25633>

On Thu, 17 Aug 2006, David Rientjes wrote:

> Cleans up builtin-mv by removing a needless check of source's length, 
> redefinition of source's length, and misuse of strlen call that was 
> already assigned.
> 

I'm not sure when this command had been added to the tree because it 
definitely was not included six months ago in a git tree I use everyday.  
It seems to me like this would more appropriately be handled by a simple 
shell script that would be much simpler to implement and could not 
possibly be slower than this implementation.

This patch is a small fraction of what could be changed in this 
implementation and I don't doubt it will undergo a complete rewrite in the 
future.  I think the problems with it have compounded on top of itself 
over time which doesn't make a lot of sense since it appears to be a 
relatively new addition.

For example:
	(length = strlen(source[i])) >= 0

was _completely_ unnecessary since the previous instruction was a call to 
lstat(source[i], ...) which would return ENOENT if source[i] was empty.  
strlen(source[i]) was assigned to a variable later in the function, this 
time called "len" instead.  There was also an additional call to 
strlen(source[i]) on its own even though the len variable was within 
scope.

This code is _utterly_ unsatisfactory.

		David
