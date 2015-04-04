From: David Turner <dturner@twopensource.com>
Subject: Re: Freeing struct lock_file?
Date: Fri, 03 Apr 2015 20:24:43 -0400
Organization: Twitter
Message-ID: <1428107083.31333.11.camel@ubuntu>
References: <1428097515.31333.2.camel@ubuntu>
	 <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 02:24:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeBtR-000486-Kj
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 02:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbbDDAYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 20:24:48 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:36623 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbbDDAYr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 20:24:47 -0400
Received: by qgeb100 with SMTP id b100so61007236qge.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 17:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CDeu8YwWDb7d8TOY7GCsZ9SV/hL56A2yoD6jfajysNY=;
        b=XmcUhkC5HFUtBZiilWk4Tmz4l7umUdWph9L+ijh93BwTtT4EKGBoB6SPM6ol8m0Wsc
         YOzrnTZXOYxSYCKldDS4pGjuK3WeLH+G6THUfLDnTkNlJyHT0r/VJYAmuAM25/Gyh6xT
         ZLNb2un4ytmZ1lmRlpVghKkSrA+UQMBIxRjBqBc+PnMXJjpeyJJvJ4NUgR1dCQdCgyZ+
         3EvNkQUL8ZwwCcGga7Yu7W2ul9jHffsp8pvjtzhv2aaetndgwWWr6CJ4f7yp/vzq/vRn
         csIdmjVix+slRqMB8pUXBHhiJoca+zLswv99eMkO/1fuRe8xh1Lyu3pkNGt7VlLDkS6w
         IfAA==
X-Gm-Message-State: ALoCoQnKIclVf8otqmoe6Uaezkbu6Ni0eZmI4/L/evvdfOM/kmP6MaZcdGHZv6wIOCt3Fbvstgd0
X-Received: by 10.140.91.201 with SMTP id z67mr5363001qgd.27.1428107087124;
        Fri, 03 Apr 2015 17:24:47 -0700 (PDT)
Received: from [172.18.24.49] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 135sm6725143qhq.23.2015.04.03.17.24.45
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 17:24:46 -0700 (PDT)
In-Reply-To: <xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266751>

On Fri, 2015-04-03 at 15:01 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Why is it impossible to free struct lock_files?  I understand that they
> > become part of a linked list, and that there's an atexit handler that
> > goes over that list.  But couldn't we just remove them from the linked
> > list and then free them? 
> 
> I suspect that the code is worried about getting a signal, while it
> is manipulating the linked list, and then cause the atexit handler
> to walk a list that is in a broken state.

This is technically possible, but practically unlikely: aligned
pointer-sized writes are atomic on very nearly every processor, and that
is all that is required to remove an item from a linked list safely in
this case (though not, of course, in the general multi-threaded case).

But I can see why git wouldn't want to depend on that behavior. C11 has
a way to do this safely, but AIUI, git doesn't want to move to C99 let
alone C11.  So I guess this will just have to remain the way it is.
