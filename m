From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/4] path: optimize common dir checking
Date: Sat, 15 Aug 2015 20:20:11 +0200
Message-ID: <55CF82DB.8010204@alum.mit.edu>
References: <1439416645-19173-1-git-send-email-dturner@twopensource.com>	 <1439416645-19173-2-git-send-email-dturner@twopensource.com>	 <55CC5DED.5050304@alum.mit.edu>	 <xmqqtws1iyxn.fsf@gitster.dls.corp.google.com> <1439582644.8855.89.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 20:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQg46-0002gc-PZ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbbHOSUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:20:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60715 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752109AbbHOSUP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2015 14:20:15 -0400
X-AuditID: 1207440d-f79136d00000402c-5e-55cf82de5fd5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.68.16428.ED28FC55; Sat, 15 Aug 2015 14:20:14 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2AF9.dip0.t-ipconnect.de [93.219.42.249])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7FIKB0b032637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 15 Aug 2015 14:20:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1439582644.8855.89.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqHuv6XyowaZjrBabnk9ktpi/6QSj
	RdeVbiaLht4rzBbdU94yOrB67Jx1l93j4iVlj+UPXrF7LHh+n93j8ya5ANYobpukxJKy4Mz0
	PH27BO6M+fPOsBcs56vYOvc0awPjSu4uRk4OCQETibN/PjJC2GISF+6tZ+ti5OIQErjMKDH/
	1FkWCOc8k8S/zjNgVbwC2hJPJ7aygtgsAqoSs9oXgsXZBHQlFvU0M4HYogJBEiuWv4CqF5Q4
	OfMJC4gtIhAhsWTyPrBeZgFniY29a4BqODiEBewk5l9whdjVDLTr+yuwGk4BC4l5y14zQ9Sr
	S/yZdwnKlpdo3jqbeQKjwCwkK2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0j
	vdzMEr3UlNJNjJAg593B+H+dzCFGAQ5GJR7exmXnQoVYE8uKK3MPMUpyMCmJ8j6IOh8qxJeU
	n1KZkVicEV9UmpNafIhRgoNZSYTXKhoox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4GUDRrOQYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS
	4gHayw3SzltckJgLFIVoPcWoKCXOO7ERKCEAksgozYMbC0tdrxjFgb4U5rUBqeIBpj247ldA
	g5mABtvNOAsyuCQRISXVwCh92aanODYkNKE5wVLq15yHSSXP7ttJHUpfdcSj0lViYXHB7xOr
	GXYubupZZSN+5Nf+pmj74LReO5H6vhsz0lyVt68yeZIWOKlNtrjvg4Dwlcjns34l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276008>

On 08/14/2015 10:04 PM, David Turner wrote:
> On Fri, 2015-08-14 at 10:04 -0700, Junio C Hamano wrote:
>> [...]
>> So I think we should have *three* functions:
>>
>>  - git_workspace_name(void) returns some name that uniquely
>>    identifies the current workspace among the workspaces linked to
>>    the same repository.
> 
> Random side note: the present workspace path name component is not
> acceptable for this if alternate ref backends use a single db for
> storage across all workspaces.  That's because you might create a
> workspace at foo, then manually rm -r it, and then create a new one also
> named foo.  The database wouldn't know about this series of events, and
> would then have stale per-workspace refs for foo.

The reference backend should clearly have functions that are called on
the creation and destruction of a workspace. In these functions the
backend could initialize / clean up any reference-related resources
associated with that workspace.

These functions can be empty for the filesystem backend.

> That said, with my lmdb backend, I've been falling back to the files
> backend for per-workspace refs.  This also means I don't have to worry
> about expiring per-workspace refs when a workspace is removed. 
> 
> I could change this, but IIRC, there are a fair number of things that
> care about the existence of a file called HEAD, so the fallback was
> easier.  (That is, the other way was a giant hassle).

OK, so the functions can be empty for the lmdb backend, too :-)

> [...]
> For this patch series, I don't think we need to change anything [...]
> Implementing
> Junio's proposal would not affect this series; it would just be an
> additional patch on top (or beforehand).

OK.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
