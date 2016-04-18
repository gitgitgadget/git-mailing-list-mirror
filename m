From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: Binary grep t7008 known breakage vanished on Cygwin
Date: Mon, 18 Apr 2016 16:21:49 +0100
Message-ID: <20160418152149.GD2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 17:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asAzv-0002Dy-8H
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 17:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbcDRPVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 11:21:54 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37220 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcDRPVx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 11:21:53 -0400
Received: by mail-wm0-f46.google.com with SMTP id n3so130060200wmn.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 08:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qCf97ywWCCcojaiwI95zHiLBWXv7omSbhtGbhcjnP7M=;
        b=WBVEJ20PVVwT+6EwDmzSiyeLW19lOI4/4O6SX1rOP8ZRvOU2KrWTPyK96WH7Tj4sLP
         cxSraaOk8+mawej5kp0ZDmuHSzDqXEEPNC834s8UpsYCaU8R1RdLz+sWrXa85ZZxZ93H
         NJp6sG839BjBIUgwb8PFSTVa1EVIabOpMW/NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qCf97ywWCCcojaiwI95zHiLBWXv7omSbhtGbhcjnP7M=;
        b=lvpMG5noR18/TT2Fk6odvIOGOu0oyh2yXNrU38RnHV+TkCxAK3LZViyr+s6wHyyTI9
         +WjZeGWmUV05wmlObvRfras73v74tBGyt0lKSp/F4CBY0DfQelV6bIr/Le994Xl4FBxk
         RtaT/SuKVWSvd05f3FWJf7yq2LkIWOPnLUjjAwvp+arYQJDqOdye7ENHE2tYsnpGwA1v
         AqtEENHCDsB4IyLSqrxzwxGr/CzjbtGMsuGXHUN621EQG5Mkssx568Ku0w9jsFm7YK3K
         HyjPoT82m9y8cZ4yL7eYefHqkdJfhOiiKpSv1aQACQP45VQIg4okJsdM5haBio8bj7gi
         a3Lg==
X-Gm-Message-State: AOPr4FWXZxG6rDCkib3b7y4cuw7hmYe0hx0DZZQUUZzDgIptUSKgDJWWGs9/8DEQSZccAQ==
X-Received: by 10.194.115.196 with SMTP id jq4mr35793449wjb.101.1460992912019;
        Mon, 18 Apr 2016 08:21:52 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id gr4sm28981477wjd.23.2016.04.18.08.21.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Apr 2016 08:21:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291807>

t7008.12 is marked as an expected failure, but building Git on Cygwin
including a `make configure && ./configure` step has the test
unexpectedly passing.  Building without the configure step has the test
failing as expected.

This appears to be behaviour specific to Cygwin; at least I get that
test failing on my CentOS box regardless of whether I perform the
configure step.

The "problem" here is `git grep` is matching a null byte with a "."; the
test implies that ought to work in theory but hasn't worked in practice
since the test was added in v1.7.1-101-gf96e567.  The commit message
there asserts "NUL characters themselves are not matched in any way,
though", which is evidently not the case on Cygwin, provided the
`configure` script is run.

I'm not sufficiently familiar with the standards and library interfaces
here to have any idea what the "correct" regex behaviour in this
circumstance is.

I'm not sure what the correct thing to do in the face of such an
unexpected test pass; it looks as though Cygwin Git's `grep` is going to
behave in a subtly different way to Git on other platforms as a result
of this, which is probably not ideal, but I don't know if there's
anything that "ought" to be done to either ensure consistent behaviour
across platforms, or to stop marking the test as an expected failure on
platforms where it passes.

Adam
