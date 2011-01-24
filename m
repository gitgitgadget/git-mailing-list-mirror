From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: cannot fetch arm git tree
Date: Sun, 23 Jan 2011 23:34:28 -0800
Message-ID: <4D3D2B84.6090409@eaglescrag.net>
References: <AANLkTikRrewCLGDTU7DjVssjpxz-EFK8AhRScAGPRumg@mail.gmail.com> <20110116092315.GA27542@n2100.arm.linux.org.uk> <20110116110819.GG6917@pengutronix.de> <AANLkTinrZ0GnT71GCueUUpAXM5ckq+LBd0RjA51DMR-a@mail.gmail.com> <20110116134248.GD27542@n2100.arm.linux.org.uk> <4D398C43.1000306@vollmann.ch> <20110121134728.GO14956@pengutronix.de> <20110121135725.GR13235@n2100.arm.linux.org.uk> <4D3997FE.5030109@vollmann.ch> <20110121145025.GS13235@n2100.arm.linux.org.uk> <4D3D2865.4020408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Detlef Vollmann <dv@vollmann.ch>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>,
	Jello huang <ruifeihuang@gmail.com>, git@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 24 08:35:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhGxx-0004gP-SH
	for gcvg-git-2@lo.gmane.org; Mon, 24 Jan 2011 08:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338Ab1AXHfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jan 2011 02:35:40 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:37753 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab1AXHfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jan 2011 02:35:39 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p0O7YSgb004699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 23 Jan 2011 23:34:29 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <4D3D2865.4020408@viscovery.net>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 23 Jan 2011 23:34:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165438>

On 01/23/2011 11:21 PM, Johannes Sixt wrote:
> Am 1/21/2011 15:50, schrieb Russell King - ARM Linux:
>>  SetEnv GIT_PROJECT_ROOT /var/www/git
>>  SetEnv GIT_HTTP_EXPORT_ALL
>>  ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
>>
>> Great.  Deciding that it will be http://servername.example.com/git/ is
>> really damned annoying as that's traditionally where gitweb lives,
>> which requires a different script alias.
>> ...
>> I'm really not interested in working out how to bodge this into working
>> along side the existing gitweb setup by adding lots of rewrite rules,...
> 
> It has been worked out for you already. It's just a single rule (although
> a bit longish). Look for 'ScriptAliasMatch' in
> http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html

I was going to say, I have both gitweb and smart http support running in
parallel, it's not terribly complicated.  The way I'm doing it is a bit
older (mainly that long ScriptAliasMatch broken out more), but it's
still only 11 lines to the apache config:

# Various environment setup, should be obvious
SetEnv GIT_PROJECT_ROOT /path
SetEnv GIT_HTTP_EXPORT_ALL 1
SetEnv GIT_EXEC_PATH /usr/libexec/git-core/

# Here so that we can do straight wget fetches for the objects files,
# pack files and refs heads.
# This isn't strictly neccisary, but if it's done we can use the inbuilt
# sendfile() of apache for the sending of those files vs. funneling them
# through the CGI
AliasMatch ^/(.*/objects/[0-9a-f]{2}/[0-9a-f]{38})$		/path/$1
AliasMatch ^/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$	/path/$1
AliasMatch ^/(.*/refs/heads/.*)$				/path/$1

# Meat of how to make this all work
ScriptAliasMatch "^/(.*/HEAD)$"
/usr/libexec/git-core/git-http-backend/path/$1
ScriptAliasMatch "^/(.*/info/refs)$"
/usr/libexec/git-core/git-http-backend/path/$1
ScriptAliasMatch "^/(.*/objects/info/[^/]+)$"
/usr/libexec/git-core/git-http-backend/path/$1
ScriptAliasMatch "^/pub/scm/(.*/git-upload-pack)$"
/usr/libexec/git-core/git-http-backend/path/$1
ScriptAliasMatch "^/pub/scm/(.*/git-receive-pack)$"
/usr/libexec/git-core/git-http-backend/path/$1

Just an example anyway, the paths have been shortened to fit e-mail better.

- John 'Warthog9' Hawley
