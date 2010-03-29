From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git check-attr in bare repositories
Date: Mon, 29 Mar 2010 18:15:01 -0500
Message-ID: <20100329231501.GA28194@progeny.tock>
References: <m3iq8jn3ar.fsf@winooski.ccs.neu.edu>
 <20100328014208.GA23015@progeny.tock>
 <19376.50971.397375.810974@winooski.ccs.neu.edu>
 <19376.53419.640007.930897@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Tue Mar 30 01:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwOAi-0002Ki-7y
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 01:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab0C2XO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 19:14:58 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:50824 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039Ab0C2XO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 19:14:57 -0400
Received: by ywh2 with SMTP id 2so5339259ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q4ecarKGTZ7XiBS1MhAXTPOvmnjU+RPaJCiKABKrw9o=;
        b=K84Z86fcIfp+8SDBKJWhBHwbodCaWPcLWn+eHVII7Bfx/ZoW+aPGtrKa7t7PhfkDxR
         IH03ANxtpXzv+kMH+f0IN3K0dQICi2eQIO7JNaKu55wr8r/GLJ+SbvUV7VuRvmaMoae9
         ancXlUbRVZ58tJFh5xv5ya0HMVVzsXvoguNVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q8E7pFMyqq6UXniXYQkm1Ax9dV3RGGFse8mJoJowVmqkKlSW9b0MXUxSO2qzl7RvGS
         ch2xt4N5gC4wp8ikUQA6q2L4PT+prJhbKhDExFZ0M9egWDwhK8CIlh7F5MVLpJx7q2Np
         UrN7QxqwqwmOV3DbBn1Gopn1elYschvUAcrW4=
Received: by 10.150.175.2 with SMTP id x2mr5293297ybe.180.1269904495696;
        Mon, 29 Mar 2010 16:14:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4417944iwn.8.2010.03.29.16.14.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 16:14:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19376.53419.640007.930897@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143531>

Eli Barzilay wrote:
> On Mar 29, Eli Barzilay wrote:
>> On Mar 27, Jonathan Nieder wrote:
[in a bare repository]

>>>  GIT_INDEX=tmp-index git check-attr "$@" &&
[...]
>> I tried that, but it doesn't work.  (I used GIT_INDEX_FILE.)

Yes, not sure how I confused myself.

git explicitly guards against that in attr.c.

	/*
	 * Read from parent directories and push them down
	 */
	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {

That check comes from v1.5.6-rc3~9^2 (Ignore .gitattributes in bare
repositories, 2008-06-08).  This is consistent with how bare
repositories generally work: they are guarded against use with a
populated index, since what filesystem tree would that index track?

To support your use case, it would be nice for check-attr to learn a
--direction option.  Maybe it would be safe to let check-attr read
from the index in bare repositories by default anyway, since the
index is usually missing anyway.

Properly supporting general work in a bare repository would require
a larger effort.  Maybe:

 - Teach code that checks is_bare_repository() to check
   get_git_work_tree() == NULL or similar instead.

 - Make the work_tree and git_dir variables the responsibility of the
   setup code.

 - If the user sets GIT_INDEX_FILE or GIT_WORK_TREE, let the setup
   code respect that wish even if core.bare is set.

Thoughts?
Jonathan
