From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 2/4] path: optimize common dir checking
Date: Wed, 26 Aug 2015 18:19:05 -0400
Organization: Twitter
Message-ID: <1440627545.26055.8.camel@twopensource.com>
References: <1440618365-20628-1-git-send-email-dturner@twopensource.com>
	 <1440618365-20628-3-git-send-email-dturner@twopensource.com>
	 <xmqqwpwh21ky.fsf@gitster.dls.corp.google.com>
	 <1440627031.26055.5.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 00:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUj2H-0000Y9-CB
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbHZWTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 18:19:08 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35209 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbbHZWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 18:19:07 -0400
Received: by qgj62 with SMTP id 62so910619qgj.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 15:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=cu46uRUdaioRNFg1Mfy/iBrhfyUkea9XlCab8pRDgo8=;
        b=YytvJd+86IGKKUfMFzublXHA4/eoYg4SC7lMdjmhPNjDkwejso6JPF0URYAew0QwkB
         5LD65tNz3ymInvwuI82QKi0qPKbW74T0RbWntCWT2rJrcy4maZQ722VBUkX5RaePXiYM
         jAy3qmhz1aL62dOp9m5aofP80mhINEUkwUpL/QK3YpJkZPkhHGiMckKbrAOJwH3/idlX
         C5AaE5JmMxamdny6gx6OBHM3wzU6HSXrbt+uJpPW734D8sJFOSmrssJX6GH7j9yNJB8/
         3Y9dyy853LzXOatbyR9fqJWwnYUPz9pFgvVpmNOIRH4zopJ2FYtByiyQon3RVRAoGrL9
         YVYQ==
X-Gm-Message-State: ALoCoQn/SxKbAbRiYVUvzDByi7vuRP23DCXsCQ9HhRPAGuSXqr/wFKDKNxcd9/mb1rlvuy14ZpTs
X-Received: by 10.140.146.214 with SMTP id 205mr1535903qhs.71.1440627546736;
        Wed, 26 Aug 2015 15:19:06 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e19sm65876qhc.18.2015.08.26.15.19.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2015 15:19:05 -0700 (PDT)
In-Reply-To: <1440627031.26055.5.camel@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276645>

On Wed, 2015-08-26 at 18:10 -0400, David Turner wrote:
> On Wed, 2015-08-26 at 14:15 -0700, Junio C Hamano wrote:
> > > + * For example, consider the following set of strings:
> > > + * abc
> > > + * def
> > > + * definite
> > > + * definition
> > > + *
> > > + * The trie would look look like:
> > > + * root: len = 0, value = (something), children a and d non-NULL.
> > 
> > "value = NULL", as there is no empty string registered in the trie?
> 
> Indeed.
> 
> > > + *    a: len = 2, contents = bc
> > 
> > "value = NULL" here, too (just showing I am following along, not
> > just skimming)?
> 
> Yep.

No, wait. value should be non-NULL, since abc is in the string set. 
