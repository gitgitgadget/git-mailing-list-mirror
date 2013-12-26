From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] safe_create_leading_directories(): fix a mkdir/rmdir
 race
Date: Thu, 26 Dec 2013 15:02:04 -0800
Message-ID: <20131226230204.GZ20443@google.com>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
 <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 27 00:02:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwJwn-0004Ru-4k
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 00:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab3LZXCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 18:02:10 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:56163 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752986Ab3LZXCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 18:02:08 -0500
Received: by mail-qc0-f178.google.com with SMTP id i17so8197093qcy.9
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R8Y9sCunabLqRHjJg0KKPEJbh19QRPuV7mo8GAfCgU0=;
        b=jXlnMEnpEaCKeozT0IYzoafXtWfHx4y1gOAygEpuvNhd6Wsb70n6pwhbvD9oogPQvs
         R/tdFyUlZX4ENnE+qkg470RvDtC+ZckQjNcjreyj9QMIslf9XOC4MxHMY041/dQ9wu9N
         8oVPmz+DALX/U3twG8c/lJQCRxjnqh7MlZGv/nQuMrhIcY1dTIZX3zmQEdu2y0VorvMv
         zf8vAQNdXF9z+InmsIGvBXaWvNpx75DeRG5B86/9/v0A2mSHoQ92sTBSb7GyqJzj46N5
         6S2TI7PdBH4NRIK/Kp+l4Eaqqr0QkjWmCU3BoqWtB+g5XFDJF1LEHVNkXrZQcPvLLEBM
         +7mQ==
X-Received: by 10.224.55.197 with SMTP id v5mr75875201qag.9.1388098927835;
        Thu, 26 Dec 2013 15:02:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v10sm40361209qeh.14.2013.12.26.15.02.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 15:02:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387696451-32224-5-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239717>

Hi,

Michael Haggerty wrote:

> It could be that some other process is trying to clean up empty
> directories at the same time that safe_create_leading_directories() is
> attempting to create them.  In this case, it could happen that
> directory "a/b" was present at the end of one iteration of the loop
> (either it was already present or we just created it ourselves), but
> by the time we try to create directory "a/b/c", directory "a/b" has
> been deleted.  In fact, directory "a" might also have been deleted.

When does this happen in practice?  Is this about git racing with
itself or with some other program?

I fear that the aggressive directory creator fighting the aggressive
directory remover might be waging a losing battle.

Is this about a push that creates a ref racing against a push that
deletes a ref from the same hierarchy?

> So, if a call to mkdir() fails with ENOENT, then try checking/making
> all directories again from the beginning.  Attempt up to three times
> before giving up.

If we are racing against a ref deletion, then we can retry while our
rival keeps walking up the directory tree and deleting parent
directories.  As soon as we successfully create a directory, we have
won the race.

But what happens if the entire safe_create_leading_directories
operation succeeds and *then* our racing partner deletes the
directory?  No one is putting in a file to reserve the directory for
the directory creator.

If we care enough to retry more than once, I fear this is retrying at
the wrong level.

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  sha1_file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Tests?

The code is clear and implements the design correctly.

Thanks for some food for thought,
Jonathan
