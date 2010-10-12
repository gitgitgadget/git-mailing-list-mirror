From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] fast-import: Let importers retrieve the objects
 being written
Date: Tue, 12 Oct 2010 17:38:27 -0500
Message-ID: <20101012223827.GB15587@burratino>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
 <1286891424-2067-3-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 00:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5nXf-0002gx-8q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 00:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab0JLWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 18:41:50 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63258 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab0JLWlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 18:41:49 -0400
Received: by qyk5 with SMTP id 5so1053018qyk.19
        for <git@vger.kernel.org>; Tue, 12 Oct 2010 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wvGfj5r2kp2Tncnwr/25N+iVjBrMmoXJKd/NnXwR9/8=;
        b=IpD0kjiB/ejbkEpQPUvVMGcLJ2QyG5jGNwlfwzdx0n461veLunLGdSQAY/ANjMiwKe
         ZWK8ouOWXgGn22cu8quOo2PV3ntMkamFsj7XeAxaMZsoQdiy5FS/nIZYBo8ps6deME8m
         2sDpPxD44tr2K7RVpXNzn1YAxdXn0agEpsDws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ci0qS9q3EatYuL164Eg3YzlVJ6RwE4mCUAIgtiX3ggJhjDNCpNSOO2cxiQ388HBzQ1
         LjXWa5sufRiGQDrFu2GMXJLv/ehuVJzQlEX6YVnOavumdh10vj6wc5uvjPglKH/qA9un
         NDKVrN74SiJS0cM3fVdyDsnKu1Y5/MPtnuywg=
Received: by 10.229.223.210 with SMTP id il18mr6766908qcb.133.1286923307769;
        Tue, 12 Oct 2010 15:41:47 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t17sm5770935qcp.2.2010.10.12.15.41.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 12 Oct 2010 15:41:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286891424-2067-3-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158886>

David Barr wrote:

> The output uses the same format as "git cat-file --batch".

This means:

	<sha1> SP <type> SP <size> LF
	<contents> LF

where <contents> are the raw content of the object in question.

If a person just wants to read the <sha1>, the <contents> are
wasted computation and I/O.  Does that matter?

Suppose some day fast-import gains a feature to respond to requests
out of order.  The response would need to include the name of the
object as requested for the frontend to make any sense of it.  Would
it be worth preparing the format for that now, so the same frontend
code can deal with the format produced by fast-import with and without
that feature?

The format of tags, trees, and commits (though not blobs) is specific
to git: fast-import backends for other version control systems would
not be able to respond in the same way.  So maybe it would make sense
to restrict cat requests to blobs for now.

> Objects can be specified by path within a tree as well, using a
>
>  cat TREE "PATH"
>
> syntax.  With this syntax, also, the tree can only be specified by
> :n marker or 40-digit tree id.

I would prefer

	cat "<path>"

within commit commands, which would spit out the content at that
path in the currently-staged version of the commit, and a separate

	C <tree> "<path>" "<path>"

to copy data from previous commits.  So cat <tree> "<path>" would be
replaced with

	C <tree> "<path>" "dest"
	cat "dest"

when using content from tree:path to prepare dest.  Of course, that
would be less flexible, but I find it more intuitive for svn-fe at
least, perhaps because it fits better with svn's object model.

In either regime, I hear there is some demand for allowing commits to
be used in place of trees.

At any rate, that is not needed for the current version of svn-fe,
is it?  So maybe it would make sense to strip down the patch to just
allow

	cat <blob>

Thanks for resending it.
