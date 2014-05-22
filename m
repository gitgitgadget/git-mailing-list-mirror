From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 41/44] refs.c: add a new flag for transaction delete
 for refs we know are packed only
Date: Thu, 22 May 2014 11:17:22 -0700
Message-ID: <20140522181722.GT12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-42-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXYZ-0006md-6D
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 20:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbaEVSR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 14:17:28 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54283 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbaEVSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 14:17:25 -0400
Received: by mail-pb0-f50.google.com with SMTP id ma3so2859054pbc.37
        for <git@vger.kernel.org>; Thu, 22 May 2014 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VzWI0VZuJ3sh1IviVCQV0IAVzJADw+FCtZia7aHQkWk=;
        b=LWG70r+Ln6ymdy6w13w+tQ4pvTXO+qEb/IgmJ5vKdw+4K8iHIEMayoWJbTJTV4VQpB
         R60iI4VxllttSsENlud++SF08Yj5fNlHbvLJNob0KPE396k2ptiucag7wWaGUZlN34gl
         8ZgmLSSCp95WqkwMqxqufoUOD0gMmQCIba9wbgCku9s0r3ow1mMkfudXsxGfK4JdYoiH
         qrZY8/QPH/g7IanuQGOGHXXnZP6yNLY45d57v0kvk0nAy+8pt3KoHRcaugamcMdtlwHC
         A3BkZj876RurucwnzhdAp+8ZBeSD3VdVnp7/lBqB0/sOdW7yWM3II9oOPhKVpb6YoGHJ
         0oIw==
X-Received: by 10.68.202.74 with SMTP id kg10mr37449770pbc.163.1400782645418;
        Thu, 22 May 2014 11:17:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id io6sm2264915pac.44.2014.05.22.11.17.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 11:17:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-42-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249927>

Hi,

Ronnie Sahlberg wrote:

> Add a new flag REF_ISPACKONLY that we can use in ref_transaction_delete.
> This flag indicates that the ref does not exist as a loose ref andf only as
> a packed ref. If this is the case we then change the commit code so that
> we skip taking out a lock file and we skip calling delete_ref_loose.

This seems wrong.  Can't someone else create a loose ref which will
shadow the packed ref and break the serializability of updates to this
ref?

The above doesn't explain why we want to avoid locking the loose ref,
but I assume it's for the sake of the "git branch -m foo/bar foo"
case.  For that case, wouldn't the following sequence of filesystem
operations work?

	- create $GIT_DIR/refs/heads/foo/bar.lock
	- create $GIT_DIR/refs/heads/foo.lock
	- if $GIT_DIR/refs/heads/foo/bar exists, add the ref to
	  packed-refs (using the usual lockfile-update mechanism)
	  and unlink $GIT_DIR/refs/heads/foo/bar
	- verify that current foo and foo/bar state are okay.  If
	  not, roll back.
	- unlink $GIT_DIR/refs/heads/foo/bar.lock
	- rmdir $GIT_DIR/refs/heads/foo
	- rename $GIT_DIR/refs/heads/foo.lock into place

Or:

	- create $GIT_DIR/refs/heads/foo/bar.lock
	- create $GIT_DIR/refs/heads/foo.lock
	- verify state of all relevant refs

	- update packed-refs to remove refs/heads/foo/bar and
	  add refs/heads/foo

	- unlink $GIT_DIR/refs/heads/foo/bar
	- unlink $GIT_DIR/refs/heads/foo
	- unlink $GIT_DIR/refs/heads/foo/bar.lock
	- unlink $GIT_DIR/refs/heads/foo.lock

Thanks,
Jonathan
