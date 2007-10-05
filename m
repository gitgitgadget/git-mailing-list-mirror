From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 08:26:44 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
References: <20071005082026.GE19879@artemis.corp>
 <20071005085522.32EFF1E16E@madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 17:28:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idp5q-0005NR-73
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 17:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbXJEP1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 11:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbXJEP1t
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 11:27:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44646 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbXJEP1t (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 11:27:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95FQnCm013037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 08:26:55 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95FQiTj003866;
	Fri, 5 Oct 2007 08:26:44 -0700
In-Reply-To: <20071005085522.32EFF1E16E@madism.org>
X-Spam-Status: No, hits=-3.241 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60093>



On Fri, 5 Oct 2007, Pierre Habouzit wrote:
>  
> -	strbuf_grow(buf, len);
> +	/* only grow if not in place */
> +	if (strbuf_avail(buf) + buf->len < len)
> +		strbuf_grow(buf, len - buf->len);

Umm. This is really ugly.

The whole point of strbuf's was that you shouldn't be doing your own 
allocation decisions etc. So why do it?

Wouldn't it be much better to have a strbuf_make_room() interface that 
just guarantees that there is enough room fo "len"? 

Otherwise, code like the above would seem to make the whole point of a 
safer string interface rather pointless. The above code only makes sense 
if you know how the strbuf's are internally done, so it should not exists 
except as internal strbuf code. No?

		Linus
