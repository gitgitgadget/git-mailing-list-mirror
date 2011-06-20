From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH v2 10/20] git-remote-testgit: fix error handling
Date: Mon, 20 Jun 2011 12:50:39 -0500
Message-ID: <jfzVoEhsVKgfY8Vp692jfTk1lNp2lhg9JCJc8MiY6N6th3PzBJoHzw@cipher.nrlssc.navy.mil>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com> <1308496725-22329-11-git-send-email-srabbelier@gmail.com> <20110619225810.GG23893@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 19:51:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYidH-0007Xi-Cn
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 19:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1FTRv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 13:51:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53703 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab1FTRvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 13:51:25 -0400
Received: by mail.nrlssc.navy.mil id p5KHodVc007509; Mon, 20 Jun 2011 12:50:39 -0500
In-Reply-To: <20110619225810.GG23893@elie>
X-OriginalArrivalTime: 20 Jun 2011 17:50:39.0832 (UTC) FILETIME=[915AB580:01CC2F72]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176081>

On 06/19/2011 05:58 PM, Jonathan Nieder wrote:

> Sverre Rabbelier wrote:
> 
> Have you checked if this still works with python 2.4?  Cc-ing Brandon
> in case he has advice.
> 

> Based on <http://pydoc.org/2.4.1/subprocess.html>, Python 2.4 doesn't
> seem to have a CalledProcessError type.  Maybe these code paths
> weren't being exercised before.

Well, I don't see anywhere where CalledProccessError is actually caught.
i.e. I don't see

   except subprocess.CalledProcessError:

anywhere.  So, on python 2.5+ if this exception is ever raised, the
script would just exit and produce a backtrace right?  And the last
line would look something like this:

     File "XXX", line XX, in check_call
       raise subprocess.CalledProcessError(retcode, cmd)
   subprocess.CalledProcessError: Command '['XXX', 'YYY', 'ZZZ']' returned non-zero exit status 1

On python 2.4, it would also exit and produce a backtrace that
looks like this:

     File "test.py", line 11, in check_call
       raise subprocess.CalledProcessError(retcode, cmd)
   AttributeError: 'module' object has no attribute 'CalledProcessError'

So, maybe it would work on python 2.4, but for the wrong reasons.
Since the CalledProcessError is never caught, couldn't we just
print an error message and exit(1) within Sverre's check_call
implementation?

Btw. the only reason I submitted those changes to support python 2.4
was because RHEL 5.X ships with python 2.4, and the changes were not
too intrusive.  So, it should be considered whether supporting 2.4
is desirable.  I wouldn't want to increase the maintenance burden
on the real python developers (i.e. not me).

Also, sorry about introducing this bug.  I'm definitely no python guru.

-Brandon
