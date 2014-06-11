From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH 0/4] ack recoding in commit log
Date: Wed, 11 Jun 2014 10:05:46 +0200
Message-ID: <53980DDA.1040407@gmail.com>
References: <1400447743-18513-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 10:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WudXi-0004XV-UO
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 10:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494AbaFKIFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 04:05:54 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61639 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbaFKIFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 04:05:50 -0400
Received: by mail-wi0-f174.google.com with SMTP id bs8so1075661wib.7
        for <git@vger.kernel.org>; Wed, 11 Jun 2014 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=dA2bKavm3ocW1ZxCLVgt0u1zbrv1g2NbTKttQ57OOzA=;
        b=mp5CLydZ4XXm114cww5i4FAqb1O/SHaAuOHLFn2bt4x8+YGXcz+cmF/nJ3Kj0q9MQr
         2QVXmqSKXUOKK3B/KJNADdBg3kCkJr+t49hQ7ZB4tuwmFh4kcDLvK3XNwJR0CQnAr6nV
         afyo7IWVSea3yMO/5iBhTOHta1+Vy7hQcQKcw2jrz38XiLwIOXjU3w2CEx761Ut/EtZj
         9zj12VZZNuNTqDVdWxBEi586Q1/xFXG62sDuS3ORseHlxNgL5rTF6tvDUnDsVseGGylg
         9gnx1zc9k+8740xZCG/CN6nn53TwRFflCulf2TaHCIMbjPu3OGmxMwvmIXrtJWvjZPNg
         T7ew==
X-Received: by 10.180.13.239 with SMTP id k15mr45356724wic.4.1402473948798;
        Wed, 11 Jun 2014 01:05:48 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id 8sm57976041eea.10.2014.06.11.01.05.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Jun 2014 01:05:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1400447743-18513-1-git-send-email-mst@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251341>

Hi Michael,

On 05/18/2014 11:17 PM, Michael S. Tsirkin wrote:
> As a maintainer, I often get patches by mail, then
> acked-by,reviewed-by etc responses are sent by separate
> mail.
> 
> I like making acks commits,
> this way they are easy to keep track of
> as part of git history.

In order to fully understand your additions, I think, I need some
clarification on the term "ack commit". What is an ack commit exactly?
Suppose our principal commit has the commit message

    Some changes

    The changes are...

    Signed-off-by: A U Thor <author@example.com>

and we receive an email from Somebody saying

    > Some changes
    >
    > The changes are...
    >
    > Signed-off-by: A U Thor <author@example.com>

    Reviewed-by: Somebody <somebody@example.com>

. Now, if I understand correctly, we create an empty commit on top of
the principal commit using the following commit message.

    Some changes

    Reviewed-by: Somebody <somebody@example.com>

Is this commit then called an ack commit?

Can an ack commit be non-empty?

Is a commit still an ack if its description mentions additional text
between the subject and the tag lines?

Maybe the ack command for todo lists and ack commits have little to do
with one another. If we stick to the term "ack commit", then the command
name suggests that it takes the tags from some commit b and appends them
to the list of tags in the previous commit's (a) message:

    pick a A commit
    ack  b The next commit

However, this obviously does not work by just appending messages. For
instance, there could be additional text before or after some tag line
in either commit message. If we treat the workflow you described as a
very specific use case of the ack command instead, it seems reasonable
to add such a todo list functionality for melding commits by silently
appending messages. However, we might consider parametrizing a single
squash command instead of defining just another name that one has to
keep in mind for melding commits:

    pick             a A commit
    squash --no-edit b The next commit

> Since response mail happens to have appropriate
> subject matching the patch, it's a natural fit to
> then use git rebase mechanics if we want to smash
> these acks into the original commit.
> 
> I have been using these patches without any problems
> for a while now, and find the approach very convenient.
> 
> Included:
> 	rebase: new ack! action to handle ack commits
> 		this part seems ready for merge to me,
> 		please review and comment
> 
> 	git-ack: new tool to record an ack
> 		this does not have proper documentation
> 		and tests yet, I definitely intend to
> 		do this but wanted to see whether people
> 		like the UI first.
> 		posting for early review and feedback
> 
> [..]

Thanks for your time,
   Fabian
