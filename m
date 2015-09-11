From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bloom filters for have/want negotiation
Date: Fri, 11 Sep 2015 14:42:02 -0700
Message-ID: <xmqqfv2kzl91.fsf@gitster.mtv.corp.google.com>
References: <55F343F5.6010903@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>,
	Wilhelm Bierbaum <bierbaum@gmail.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 11 23:42:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaW5C-0000Jb-TA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 23:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978AbbIKVmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 17:42:06 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36144 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbbIKVmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 17:42:05 -0400
Received: by padhk3 with SMTP id hk3so85178848pad.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=axW3taykmlEYi/DaahCA0j/OYWsdWPsqcZTfsqAKclw=;
        b=siXU1YyQ8w4tf/MZ2tP/TJRB9Xm3MGtGE9Jttq0apeqQvFIIyWlCpzQ22GNjALAOMC
         31QfvQDfiHJh+9MUawdloudfQIaveeZZdtHFNZpqy4ty1vaR1jdh7aMX6Kiy2fnVDHES
         DKdZgFemtHEBLJAuVJ4l5KnVtjmv2OQSFus6O/L/0b3wF4podUvCfFRl7/hbI/+PJldq
         rgJZb09szGfsee5iGcA5uJJIAxYZHFEmsoU2z6Z+B+blAJqedfoWf/CQOHs8+GC+5jm7
         92gGmnrBp4W9L1eN1XJmEvGw2d96WOGIJACkaGXY1AZGcLIRNs3zKFG7a8xjj72IFi8b
         xwXA==
X-Received: by 10.67.15.36 with SMTP id fl4mr2027827pad.152.1442007724032;
        Fri, 11 Sep 2015 14:42:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id ok4sm2136222pbb.65.2015.09.11.14.42.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 14:42:03 -0700 (PDT)
In-Reply-To: <55F343F5.6010903@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 11 Sep 2015 23:13:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277698>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. The server advertises the references that it has in the way that it
> is currently done.
> 2. The client advertises the objects that it has (or some subset of
> them; see below) via a Bloom filter.
> 3. The server sends the client the packfile that results from assuming
> that the Bloom filter is giving correct answers. (This might mean that
> too few objects are sent to the client.)

Wouldn't this end up sending objects the server has (perhaps
reachable from a branch that is not advertised to the client) that
is not reachable from the tips the client asked upon a false hit?
If so, that has security ramifications for servers who restrict what
you can download based on who you are (and which branches are
supposed to be visible to you).

Using bloom filter (perhaps invertible ones) to identify what the
receiving end lacks is certainly an intriguing approach, though.
