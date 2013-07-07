From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sun, 7 Jul 2013 10:53:16 -0700
Message-ID: <20130707175316.GB9975@google.com>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com>
 <51D7C47D.5070700@acm.org>
 <20130707002804.GF30132@google.com>
 <51D8E40F.2020008@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, users@subversion.apache.org,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:53:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvt9I-0008Fa-Ly
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3GGRxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:53:21 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46302 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337Ab3GGRxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:53:20 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp12so3614264pab.35
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aYErpTITnLWNy42mbWwOoXWDOiA+Bjsnpu2P2ZzvVQo=;
        b=ws/69meRavjDPKGujuoKBDiOtXEGCD4oTKzFlbhR4gkHLogizW7252LWhHorYjFVR4
         ZSgRwO7pkgaM8abgO4ujAAMJDppFa6OMsWfF9pzUCKeer4+C4+bfzq+k0BNmsu3uw56C
         N+1ViLgvzjXqubzEA1TMck7OUlZMmdMhGOmixvgIPJ/Qh7Jq1pdpveVDW/46UprUzrn9
         T+6BmJdEGNXFgALLzerP/VSajqWYDYVNU439ImJnj3AX58DotKNbQ01LSF/kUzPTXN+e
         iaDKBRD+6GdhLJjEL6+2OrkIlPucJz+o6GXaPzA09igY3bbIjc9PWqGpduNjg7XjfiXQ
         QE5g==
X-Received: by 10.66.153.140 with SMTP id vg12mr19498915pab.170.1373219599816;
        Sun, 07 Jul 2013 10:53:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id kq2sm19498720pab.19.2013.07.07.10.53.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 10:53:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D8E40F.2020008@acm.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229786>

(cc-ing users@ as requested by danielsh)
David Rothenberger wrote:
> On 7/6/2013 5:28 PM, Jonathan Nieder wrote:

>> Is there a simple explanation of why violating the depth-first
>> constraint would lead to multiple blob (i.e., file, not directory)
>> deltas being opened in a row without an intervening close?
>
> I believe serf is doing the following for a number of files in parallel:
>  1. open_file
>  2. apply_textdelta
>  3. change_file_prop, change_file_prop, ...
>  4. close_file

Ah, that makes more sense.  It is not about traversal order but about
processing multiple non-directory files in parallel, and step (3)
potentially involving a large number of property changes means that it
can make sense not to take a lock.

Perhaps the reference documentation could warn about this?

On the git-svn side, it looks like we have enough information to make
a more complete commit message or in-code comment so the reason for
multiple git_blob tempfiles is not forgotten.  Thanks for your patient
explanations.

Jonathan
