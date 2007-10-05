From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [AGGREGATED PATCH] Fix in-place editing functions in convert.c
Date: Fri, 5 Oct 2007 11:05:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710051036282.23684@woody.linux-foundation.org>
References: <20071005082026.GE19879@artemis.corp> <20071005085522.32EFF1E16E@madism.org>
 <alpine.LFD.0.999.0710050819540.23684@woody.linux-foundation.org>
 <20071005162139.GC31413@uranus.ravnborg.org>
 <alpine.LFD.0.999.0710050933330.23684@woody.linux-foundation.org>
 <20071005172425.GD31413@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 20:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdrZd-0004IC-Ck
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 20:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbXJESGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 14:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbXJESGo
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 14:06:44 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57925 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232AbXJESGn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 14:06:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95I52dW000963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 11:05:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95I51aa017630;
	Fri, 5 Oct 2007 11:05:02 -0700
In-Reply-To: <20071005172425.GD31413@uranus.ravnborg.org>
X-Spam-Status: No, hits=-3.202 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,TW_VN
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60120>



On Fri, 5 Oct 2007, Sam Ravnborg wrote:
> 
> Point taken although no sane person would name it strbuf_to_c(...).

I agree with the "no sane person", but the problem is that the insane 
people seem to be in no short supply.

Go look at string libraries, and they all do something like that. Or 
worse.

 - ustr: yes, it uses *exactly* what I described: "ustr_cstr()" and 
   "ustr_len()" instead of having the data/length available easily 
   (although it claims to do it for size reasons - perhaps valid in some 
   cases!)

 - libast: SPIF_CHARPTR_C(x). No, really.

 - Vstr: doesn't have a linear data representation. Needs explicit 
   flattening - although it appears to be something you're not ever 
   supposed to do - it has 200+ functions to do various magic things. 

 - Qt (QString): QString::"data()", "ascii()" or "utf8()" or something.

   At least this has the excuse of really being able to handle different 
   locales (it didn't do that originally, though!), but they end up having 
   a million helper functions exactly because you cannot use the normal 
   string routines on anything!

 - safesrtr, bstring: you just cast the pointer to "char *". Now *that* is 
   classy and safe.

So there's a few sane out there, but I actually think they are in the 
minority (Glib, others)

			Linus
