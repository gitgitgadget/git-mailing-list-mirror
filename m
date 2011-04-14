From: Jakub Narebski <jnareb@gmail.com>
Subject: The future of gitweb - part 2: JavaScript
Date: Thu, 14 Apr 2011 11:54:53 +0200
Message-ID: <201104141154.55078.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 11:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAJGg-0006Lg-Tc
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 11:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758672Ab1DNJzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 05:55:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41738 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922Ab1DNJzL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 05:55:11 -0400
Received: by fxm17 with SMTP id 17so1055733fxm.19
        for <git@vger.kernel.org>; Thu, 14 Apr 2011 02:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=nvfqWdW+b/5nsifK0lLVwak/Bev6dMacGx8FTKMWyyc=;
        b=hGys7vIQt9wBzT6TKPXEpTi4n4UcFXpgahYEozEyc3yCDpc4Ydpw7W410I7n5jf2/T
         Obh+Ksujskz769c4rVlx/i2zzKkC7uuxN6EJsA+OQfJuX/43GKBoqwr1XAglhhcptHq4
         EAYNgMTWTC3TCqfUFcWw3drzZy8YrUqi14Kv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vJwRydbWLOuj8bFQi90+NtOQFDh9UYQQnw225DUEQ/DpVlGDvatVewT0QMEmvlVnzZ
         xDBdela+L9cFgBCbHe9G6CW+uOW5ejGAbbF04oAbqg62DU8BqaF4NTWj2+Vyga1SNS0C
         ESAm+1Xb7ZsBfxEzh/jc8AvaNuG6pg58w0uis=
Received: by 10.223.102.129 with SMTP id g1mr613560fao.3.1302774909414;
        Thu, 14 Apr 2011 02:55:09 -0700 (PDT)
Received: from [192.168.1.13] (abwc79.neoplus.adsl.tpnet.pl [83.8.226.79])
        by mx.google.com with ESMTPS id j18sm446584faa.42.2011.04.14.02.55.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2011 02:55:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201102142039.59416.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171511>

> Now that we are talking about future of git, including breaking some
> of backwards compatibility bugs / misdesigns for 1.8.0, perhaps it is
> the time to discuss long term goals and the future of gitweb.

This is second installment, talking about JavaScript (client-side)
part of gitweb code.

Recently there were sent to git mailing list a new feature which
further extended use of JavaScript in gitweb, namely adjusting common
timezone in which dates are shown:
  http://thread.gmane.org/gmane.comp.version-control.git/169384/focus=169881
  http://thread.gmane.org/gmane.comp.version-control.git/171212

It looks like there would be more proposals on (optional) enhancing
gitweb with JavaScript.

Currently JavaScript is used for the following (optional) features:
* detecting if javascript is enabled (not a feature per se)
* incremental blame (Ajax-y, requires server side knowing above)
* setting local timezone in which dates are shown

Possible other JavaScript-based enhancements include:
* sorting tables like in Wikipedia, avoiding trip to server
* MediaWiki-like history view for selecting commits to compare
  (base does not exist yet, and could be used without JavaScript)


There was one simple issue that for maintenance and readability it is
better to have code split into small modules (into separate files),
while for page performance and interactivity it is better to limit
number of scripts.  This issue can be simply solved by combining
JavaScript files on build.

There was and is more important issue, namely that in our JavaScript
we have to abstract or work around differences in web browsers, and
backport features.  This includes:
* Ajax (generating XmlHttpRequest, handling XHR events)
* emulating getElementsByClassName if native implementation is absent
* workaround differences in setting up event handlers by using 
  'elem.onevent = function () { ... }' etc.
* manipulating stylesheets (CSS)

Those issues are already solved in __JavaScript libraries__ and
frameworks, probably better way than in our attempt.  Using JavaScript
framework would also give as higher level constructs, and could
replace what we have and could have in gitweb/static/js/lib:
* popup menu like the one used to select timezone
* date parsing and formatting, string formatting
* handling cookies

Using some JavaScript framework / library could help a lot with
developing and improving JavaScript part of gitweb code.  We would no
longer need to worry so much on how to do it, but could concentrate on
what to do.

Unfortunately the decision to use JavaScript framework brings its own
new problems.

First issue is which JavaScript framework or library to use:
* jQuery (lightweight, most popular, used e.g. by MediaWiki)
* MooTools (lightweight, 2nd most popular, opbject-oriented)
* YUI, The Yahoo! User Interface Library 
* other: Prototype, Dojo, ExtJS, SproutCore,...


Second issue is how to use it / how to include it:

* Use some external Content Delivery Network (CDN), like 
  Google Libraries API 
     http://code.google.com/apis/libraries/devguide.html
  e.g.:

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script>
  <script src="http://code.jquery.com/jquery-1.5.2.min.js"></script>

  or

  <script src="https://ajax.googleapis.com/ajax/libs/mootools/1.3.1/mootools-yui-compressed.js"></script>

  This is nice solution... if we don't need plugin / extension
  which usually are not available in CDN version of library.

  Also this makes gitweb dependent on third-party service, and require
  network connectivity to Internet to have access to JavaScript-based
  features.

* Mark appropriate JavaScript library as dependency in gitweb/INSTALL
  to be downloaded in appropriate place but do not provide sources.
  Perhaps add target in gitweb/Makefile that automatically downloads
  it.

  This would make installing gitweb correctly more complicated.
  JavaScript-based features would not work if somebody instals gitweb
  incorrectly.

  I think we can set up gitweb build so that one can configure at
  build stage whether to use CDN or download library, or use
  pre-downloaded (and perhaps instaled somewhere) version of framework
  (combining JavaScript on build in all but first case).

* Provide copy in git sources (in git.git repository), minified or
  development version or both.  This would bloat git repository a bit,
  and we would probably want/have to update library at its releases.

    jQuery      | 24 kB (minified & gzipped), 72 kB (minified),
    MooTools    | 25 kB (minified & gzipped), 86 kB (minified)
    YUI         | 31 kB (library core only)
    Prototype   | 46-278 kB
    Dojo        | 28 kB (minified & gzipped), 65 kB (minified)
    ExtJS       | 84-502 kB

  Some of those, like MooTools[1] and YUI[2], include dependency
  calculator (library builder) where you can get customized version
  with only relevant/required parts included.

  [1]: http://mootools.net/core/  and  http://mootools.net/more/
  [2]: http://developer.yahoo.com/yui/3/configurator/

  Anyway it could be configurable fallback for other methods; this way
  we don't have to keep library up to date.

* Instead of including source code or build (minified) version in git
  repository, we could include JavaScript library as a _submodule_.

  This of course is possible only if library in question procides
  source repository, and if it uses Git for version control (like
  jQuery, MooTools, YUI or Prototype)... or if we can trust our remote
  helper for SCM in question (hmmm... I thought that jQuery uses
  Subversion, but it moved to Git).

  This way you don't need to have it if you don't need it... but on
  the other hand if you need it you have to download (clone) much
  larger development version.  Sidenote: I wonder how well shallow
  clone and narrow checkout works with submodules.

  And of course we would have to somehow integrate build systems,
  i.e. have git call build system of JavaScript library when building
  and installing gitweb.


We can check how other projects solve this issue:

* MediaWiki (jQuery)::

    The jQuery file is in /resources/jquery/jquery.js, loaded 
    (and minified) via ResourceLoader since version 1.17

* WordPress (jQuery)::

    jQuery (development version) is in wp-includes/js/jquery/*
    in wordpress RPM

* Movable Type (jQuery)::

    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript">google.load("jquery", "1.3.2");</script>

* Ruby on Rails (Prototype)

    jQuery (single file) is in gems/rails-*/html/javascripts/prototype.js
    in rails RPM

There is of course question if theirs approach is good for gitweb...


So what are your ideas and comments on the issue of JavaScript code
and JavaScript libraries / frameworks in gitweb?
-- 
Jakub Narebski
ShadeHawk on #git
Poland
