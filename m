From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH (BUGFIX)] gitweb: Fix parsing of negative fractional timezones
 in JavaScript
Date: Mon, 04 Apr 2011 11:30:29 -0700
Message-ID: <4D9A0E45.6060101@eaglescrag.net>
References: <20110401190239.9686.12000.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6oY7-0004pl-4F
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 20:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab1DDSaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 14:30:35 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:55896 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab1DDSae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 14:30:34 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p34IUT3F028980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 4 Apr 2011 11:30:30 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <20110401190239.9686.12000.stgit@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 04 Apr 2011 11:30:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170832>

Looks fine to me.

- John 'Warthog9' Hawley

On 04/01/2011 12:06 PM, Jakub Narebski wrote:
> Extract converting numerical timezone in the form of '(+|-)HHMM' to
> timezoneOffset function, and fix parsing of negative fractional
> timezones.
> 
> This is used to format timestamps in 'blame_incremental' view; this
> complements commit 2b1e172 (gitweb: Fix handling of fractional
> timezones in parse_date, 2011-03-25).
> 
> Now
> 
>   gitweb.cgi/git.git/blame_incremental/3fe5489:/contrib/gitview/gitview#l853
> 
> and
> 
>   gitweb.cgi/git.git/blame/3fe5489:/contrib/gitview/gitview#l853
> 
> show the same correct time in author's local timezone in title
> (on mouseover) [Aneesh Kumar K.V, 2006-02-24 00:59:42 +0530].
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> This was send earlier as part 3/3 of 
> 
>   "[PATCH/RFC 0/3] gitweb: Split gitweb.js, improve JavaScript"
>   Message-Id: <1301089586-8534-1-git-send-email-jnareb@gmail.com>
>   http://thread.gmane.org/gmane.comp.version-control.git/170021/focus=170024
> 
> It is now send separately as standalone patch, and is not held hostage
> to accepting series that splits gitweb JavaScript file.
> 
>  gitweb/static/gitweb.js |   24 +++++++++++++++++++-----
>  1 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/gitweb/static/gitweb.js b/gitweb/static/gitweb.js
> index 9c66928..40ec084 100644
> --- a/gitweb/static/gitweb.js
> +++ b/gitweb/static/gitweb.js
> @@ -399,7 +399,24 @@ function fixColorsAndGroups() {
>   * used to extract hours and minutes from timezone info, e.g '-0900'
>   * @constant
>   */
> -var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
> +var tzRe = /^([+-])([0-9][0-9])([0-9][0-9])$/;
> +
> +/**
> + * convert numeric timezone +/-ZZZZ to offset from UTC in seconds
> + *
> + * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
> + * @returns {Number} offset from UTC in seconds for timezone
> + *
> + * @globals tzRe
> + */
> +function timezoneOffset(timezoneInfo) {
> +	var match = tzRe.exec(timezoneInfo);
> +	var tz_sign = (match[1] === '-' ? -1 : +1);
> +	var tz_hour = parseInt(match[2],10);
> +	var tz_min  = parseInt(match[3],10);
> +
> +	return tz_sign*(((tz_hour*60) + tz_min)*60);
> +}
>  
>  /**
>   * return date in local time formatted in iso-8601 like format
> @@ -408,14 +425,11 @@ var tzRe = /^([+-][0-9][0-9])([0-9][0-9])$/;
>   * @param {Number} epoch: seconds since '00:00:00 1970-01-01 UTC'
>   * @param {String} timezoneInfo: numeric timezone '(+|-)HHMM'
>   * @returns {String} date in local time in iso-8601 like format
> - *
> - * @globals tzRe
>   */
>  function formatDateISOLocal(epoch, timezoneInfo) {
> -	var match = tzRe.exec(timezoneInfo);
>  	// date corrected by timezone
>  	var localDate = new Date(1000 * (epoch +
> -		(parseInt(match[1],10)*3600 + parseInt(match[2],10)*60)));
> +		timezoneOffset(timezoneInfo)));
>  	var localDateStr = // e.g. '2005-08-07'
>  		localDate.getUTCFullYear()                 + '-' +
>  		padLeft(localDate.getUTCMonth()+1, 2, '0') + '-' +
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
