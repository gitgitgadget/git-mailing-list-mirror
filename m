From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Mon, 15 Mar 2010 16:42:57 -0500
Message-ID: <s0MQZSOEsdBJUhITxC3jwfFJk5PnIEo0WR5z_GEnSOw@cipher.nrlssc.navy.mil>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st> <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil> <20100315212915.GB25342@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git@mlists.thewrittenword.com,
	kusmabite@gmail.com, martin@martin.st,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:43:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrI4F-0000IT-CB
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936909Ab0COVnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:43:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52390 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936891Ab0COVnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:43:06 -0400
Received: by mail.nrlssc.navy.mil id o2FLgwFs027137; Mon, 15 Mar 2010 16:42:58 -0500
In-Reply-To: <20100315212915.GB25342@coredump.intra.peff.net>
X-OriginalArrivalTime: 15 Mar 2010 21:42:57.0860 (UTC) FILETIME=[7A388040:01CAC488]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142260>

On 03/15/2010 04:29 PM, Jeff King wrote:
> On Mon, Mar 15, 2010 at 04:03:00PM -0500, Brandon Casey wrote:
> 
>> When NO_SOCKADDR_STORAGE is set for a platform, either sockaddr_in or
>> sockaddr_in6 is used intead.  Neither of which has an ss_family member.
>> They have an sin_family and sin6_family member respectively.  Since the
>> addrcmp() function accesses the ss_family member of a sockaddr_storage
>> struct, compilation fails on platforms which define NO_SOCKADDR_STORGAGE.
>>
>> Since any sockaddr_* structure can be cast to a struct sockaddr and
>> have its sa_family member read, do so here to workaround this issue.
> 
> Didn't Gary say that AIX 5.2 sticks sa_len at the front of their
> sockaddr?
> 
> We know that whatever we actually have (an actual sockaddr_storage, or a
> sockaddr_in, or a sockaddr_in6) will have the family at the front, so
> can you just cast it to sa_family_t?

I expect that the layout of the sockaddr_* family of structures will
follow the layout of struct sockaddr, otherwise they wouldn't be
compatible.

In other words, I think that if struct sockaddr looks like this:

  struct sockaddr {
        uchar_t         sa_len;         /* total length */
        sa_family_t     sa_family;      /* address family */
        char            sa_data[14];    /* actually longer; address value */
  };

then somewhere else, struct sockaddr_in looks like this:

  struct sockaddr_in {
        uchar_t         sin_len;
        sin_family_t    sin_family;
        sin_port;
        sin_addr;
        ...
  };

> Or am I wrong in assuming that, and on AIX sockaddr_in actually has
> sa_len at the front, so casting to sockaddr does the right thing (and my
> recommendation above would actually be broken)? The AIX boxen I have
> access to are all down at the moment.

Maybe Gary can check for us... Gary, what does the declaration for
struct sockaddr_in look like in your AIX header file?

-brandon
