From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 22 May 2014 16:44:40 -0700
Message-ID: <20140522234440.GA12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-42-git-send-email-sahlberg@google.com>
 <20140522181722.GT12314@google.com>
 <CAL=YDWkUa2Ut=1iaMXgnjgte6g5jvXR49LBiEUNEkwv4Z-wO_w@mail.gmail.com>
 <CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:44:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncfH-0008MZ-OC
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbaEVXoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:44:44 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:47760 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbaEVXon (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:44:43 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so3188801pab.34
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4Bbxzhw7yAUmE0g3cgo+IPJIeRJGtr/5aq2V8RyQWGk=;
        b=aPTUpMlck/DVRDIHQVTX6Ikx5jfMXXnTMmvJFT5zgim488ImlwIJv7tQny0BTAGkgN
         SU6v1YEHR6/kxNIcUse8oLTEYDru0269taH+zG47VoITYTmpjo7k8+276VLcqaG4jUbN
         wCp/S5x0chIJAqnwv+fQcrfBzsenyxLc6qJBWYt4N+jW5rKyNNt19xRTvWOEnpgtgSI4
         63fcuKcu5HPt+PsMLTm5U5+oFIOyqpJd6x0lVsIfx59ERDhkZ4LgLwAf8mJahgEvloxF
         P3CIlxcUjqAUfnrBkuP0VMleOyPNgPyxHSykcg37FrVoIiIz5ws3B2BZhGLoVEz+SIUW
         P+Hw==
X-Received: by 10.68.211.233 with SMTP id nf9mr1086845pbc.29.1400802283104;
        Thu, 22 May 2014 16:44:43 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iz2sm1411114pbb.95.2014.05.22.16.44.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:44:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=hytDiz5qzAMyBgXUgza+AcDhk_y3m3kAUmOdBG=F=vA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249965>

Ronnie Sahlberg wrote:

> I hate rename_ref :-)
>
> I have reworked the transaction code to special case the deletion of
> the old ref for n/n -> n  and n -> n/n renames
> so that we can carefully avoid n/n.lock files to exist or prevent the
> directory <-> file transition for n during these renames.

Thanks.

I suspect the REF_ISRENAME flag shouldn't be needed.  Wouldn't
something like the following work (in _commit)?

	Allocate work space
	Copy sort, and reject duplicate refs
	Acquire all locks while verifying old values
		This calls is_refname_available.
		If a refname is unavailable, goto slowpath.
	Perform updates first so live commits remain referenced.
	Perform deletes now that updates are safely completed.
	Done.

 slowpath:
	Acquire locks, telling is_refname_available not to worry
		about deleted refs.
	Lock packed-refs.
	Add all relevant refs to packed-refs (pack_if_possible_fn).
	Commit packed-refs.
	Unlink the corresponding loose refs so packed-refs
		becomes authoritative for them.
	Lock packed-refs.
	Perform updates and removals in the packed-refs cache.
	Commit packed-refs.
	Release locks.
	Done.

This wouldn't be any slower for the case without D/F conflicts, and in
the D/F conflict case, it should work for arbitrary transactions
that want to remove one ref to make room for another.
