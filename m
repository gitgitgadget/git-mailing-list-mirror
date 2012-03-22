From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] Isolate If-Modified-Since handling in gitweb
Date: Thu, 22 Mar 2012 14:05:12 +0100
Message-ID: <201203221405.13193.jnareb@gmail.com>
References: <20120321140429.GA28721@odin.tremily.us> <201203211755.07121.jnareb@gmail.com> <20120321173824.GA31490@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Thu Mar 22 14:05:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAhhq-0004gW-BS
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 14:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796Ab2CVNFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 09:05:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62821 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab2CVNFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 09:05:24 -0400
Received: by wgbdr13 with SMTP id dr13so1363617wgb.1
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 06:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KaVlZ5GA4QyEnoO74yxzi91z6tlDIa3yKMtCQOlFqQA=;
        b=MUqBQOcELurxySjkKxNhLvaijsUkVEQMqAYxaObfiN9aMsCZ0vCcoglZ/M0kffxvjd
         7g+ycRUu/zpEfbRKnsRhb2ElDyT9PoEgj/xziTY7RNdD1V/ma+jcDXOka8y3WO3amczS
         nia4qvUNjaHfOpeLdAnLmO7DLesJV0Y3ooqVMHV9dWcNjs7ltEPGaMObZ2/rmoc+kvZF
         AD9JRQQOfCZZKehOzdl2oD6SZTcPq4TuF5nWbHCnm1wtsopoeLU4MFjI7JfxnSLXE1yM
         m/rJ+QBlyviSx/L/OqC5E7ULyeWgAZT+rReLWErNPdC0oCL1m0cAp9ss+8G+COaY2ZzM
         iubw==
Received: by 10.180.76.74 with SMTP id i10mr4996369wiw.2.1332421523484;
        Thu, 22 Mar 2012 06:05:23 -0700 (PDT)
Received: from [192.168.1.13] (abwe160.neoplus.adsl.tpnet.pl. [83.8.228.160])
        by mx.google.com with ESMTPS id fn2sm8739741wib.0.2012.03.22.06.05.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 06:05:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120321173824.GA31490@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193654>

On Wed, 21 Mar 2012, W. Trevor King wrote:
> On Wed, Mar 21, 2012 at 05:55:06PM +0100, Jakub Narebski wrote:

> > There is a tool to create patches to send: git-format-patch.  Myself I
> > usually create a new directory for a patch series, e.g. mdir.if_mod.v3,
> > and use git-format-patch to populate it, e.g.
> 
> Ah, I like that.  Then I can rebase away ;).

Yep.  Or use some patch / mailqueue management interface like StGit.
 
> > I think it would be better to add initial tests with refactoring, and
> > snapshot specific tests with snapshot support, e.g.:
> > 
> >   1/2: gitweb: Refactor If-Modified-Since handling and add tests
> >   2/2: gitweb: Add If-Modified-Since support for snapshots
> 
> But the new tests would be for the new functionality (i.e. snapshot
> support), so they wouldn't belong in the general refactoring commit.

I was thinking that "and add tests" would be about 'feed' action test
and i-m-s.

> > Currently all of those work
> > 
> >     http://.../gitweb.cgi?p=git.git;a=snapshot;h=v1.7.6;sf=tgz
> >     http://.../gitweb.cgi?p=git.git;a=snapshot;h=f696543d;sf=tgz"
> >     http://.../gitweb.cgi?p=git.git;a=snapshot;h=b1485af8;sf=tgz"
> > 
> > v1.7.6 is a tag, f696543d is a commit (v1.7.6^{}), b1485af8 is a tree
> > (v1.7.6^{tree}).
> > 
> > The last URL would stop working after your change with 404
> > "Unknown commit object".
> 
> Indeed it does.  I'll add you're suggested skipping for these cases.

If by "skipping" you mean here turning off handling of If-Modified-Since
and Last-Modified headers, then I agree.
 
> There should be a way to determine the oldest commit refering to a
> tree, which could be used for timestamping tree-ishes, but that can be
> a project for another day ;).

That also can be ambiguous.

-- 
Jakub Narebski
Poland
