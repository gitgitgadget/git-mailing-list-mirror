From: Mark Rada <marada@uwaterloo.ca>
Subject: Re: [PATCHv4] gitweb: fill in missing parts of minify support
Date: Wed, 24 Mar 2010 12:38:15 -0400
Message-ID: <4BAA3FF7.9040100@mailservices.uwaterloo.ca>
References: <4BA5133E.6050901@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 17:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuTbl-0002dL-85
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 17:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab0CXQi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 12:38:59 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:40131 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753271Ab0CXQi6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Mar 2010 12:38:58 -0400
Received: from karakura.local (static-66-225-153-161.ptr.terago.net [66.225.153.161])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o2OGcFbi031837
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Mar 2010 12:38:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <4BA5133E.6050901@mailservices.uwaterloo.ca>
X-UUID: 98e390df-c533-40e9-aea7-5b475db1f49d
X-Miltered: at mailchk-m05 with ID 4BAA3FF7.002 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Wed, 24 Mar 2010 12:38:18 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143093>

Hi,

Has this been dropped? Does it need to be modified in some way?

Thanks,

-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca


On 10-03-20 2:26 PM, Mark Rada wrote:
> JavaScript minification was added to the git build system, but it was a
> hidden away feature that did not play by all the rules and broke
> instaweb when minifying was enabled.
> 
> This patch fixes instaweb support and adds rules to the build system to
> take care of minified files; this includes an autoconfigure option so
> that users do not need to edit the makefiles directly, as well as
> documentation updates related to gitweb.js and optional minify support.
> 
> This patch also adds support to minify gitweb.css, the effect is not as
> dramatic as minifying gitweb.js, but every saved byte of bandwidth helps.
> 
> Signed-off-by: Mark Rada <marada@uwaterloo.ca>
> 
> ---
> 
> Changes since v3:
> 	- Patch wouldn't apply because it depended on another patch
> 	  I sent in that has not yet been applied. Junio wondered if part
> 	  of that patch belonged here (or vice versa?), which at the time
> 	  did not seem right to me, but now that this patch has grown, it
> 	  does---Ignore the patch titled "instaweb: use minified gitweb.js
> 	  if available", it is squashed in here now 
> 	- Changed some the INSTALL updates to be less wordy
> 	- The patch became more broad, to support minification in general,
> 	  which includes gitweb.css
> 
> 	
>  .gitignore      |    1 +
>  Makefile        |   33 ++++++++++++++++++++++-----------
>  configure.ac    |   20 ++++++++++++++++++++
>  git-instaweb.sh |    6 ++++--
>  gitweb/INSTALL  |   30 +++++++++++++++++++++---------
>  gitweb/Makefile |   31 +++++++++++++++++--------------
>  gitweb/README   |    3 ++-
>  7 files changed, 87 insertions(+), 37 deletions(-)
> 
> diff --git a/.gitignore b/.gitignore
> index 7b3acb7..4c24152 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -156,6 +156,7 @@
>  /git-core-*/?*
>  /gitk-git/gitk-wish
>  /gitweb/gitweb.cgi
> +/gitweb/gitweb.min.*
>  /test-chmtime
>  /test-ctype
>  /test-date
> diff --git a/Makefile b/Makefile
> index 7c616f8..19c7ef0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -203,6 +203,9 @@ all::
>  # Define JSMIN to point to JavaScript minifier that functions as
>  # a filter to have gitweb.js minified.
>  #
> +# Define CSSMIN to point to a CSS minifier that performs the same
> +# function as a JavaScript minifier, but for CSS files.
> +#
>  # Define DEFAULT_PAGER to a sensible pager command (defaults to "less") if
>  # you want to use something different.  The value will be interpreted by the
>  # shell at runtime when it is used.
> @@ -279,8 +282,6 @@ lib = lib
>  # DESTDIR=
>  pathsep = :
>  
> -# JavaScript minifier invocation that can function as filter
> -JSMIN =
>  
>  export prefix bindir sharedir sysconfdir
>  
> @@ -1551,19 +1552,27 @@ gitweb:
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
>  
>  ifdef JSMIN
> -OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
> -gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
> +GITWEB_JS=gitweb/gitweb.min.js
> +else
> +GITWEB_JS=gitweb/gitweb.js
> +endif
> +
> +ifdef CSSMIN
> +GITWEB_CSS=gitweb/gitweb.min.css
>  else
> -OTHER_PROGRAMS += gitweb/gitweb.cgi
> -gitweb/gitweb.cgi: gitweb/gitweb.perl
> +GITWEB_CSS=gitweb/gitweb.css
>  endif
> +
> +OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_JS) $(GITWEB_CSS)
> +
> +gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
>  
> -ifdef JSMIN
>  gitweb/gitweb.min.js: gitweb/gitweb.js
>  	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
> -endif # JSMIN
>  
> +gitweb/gitweb.min.css: gitweb/gitweb.css
> +	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
>  
>  git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
> @@ -1572,10 +1581,12 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.
>  	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
>  	    -e '/@@GITWEB_CGI@@/r gitweb/gitweb.cgi' \
>  	    -e '/@@GITWEB_CGI@@/d' \
> -	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
> +	    -e '/@@GITWEB_CSS@@/r $(GITWEB_CSS)' \
>  	    -e '/@@GITWEB_CSS@@/d' \
> -	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
> +	    -e '/@@GITWEB_JS@@/r $(GITWEB_JS)' \
>  	    -e '/@@GITWEB_JS@@/d' \
> +	    -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
> +	    -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
>  	    $@.sh > $@+ && \
>  	chmod +x $@+ && \
> @@ -2076,7 +2087,7 @@ clean:
>  	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
>  	$(MAKE) -C Documentation/ clean
>  ifndef NO_PERL
> -	$(RM) gitweb/gitweb.cgi
> +	$(RM) gitweb/{gitweb.cgi,gitweb.min.*}
>  	$(MAKE) -C perl clean
>  endif
>  ifndef NO_PYTHON
> diff --git a/configure.ac b/configure.ac
> index 914ae57..cc7df85 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -179,6 +179,26 @@ fi],
>     AC_MSG_NOTICE([Will try -pthread then -lpthread to enable POSIX Threads.])
>  ])
>  
> +# Define option to enable JavaScript minification
> +AC_ARG_ENABLE([jsmin],
> + [AS_HELP_STRING([--enable-jsmin=ARG],
> +   [ARG is the value to pass to make to enable JavaScript minification.])],
> + [
> +   JSMIN=$enableval;
> +   AC_MSG_NOTICE([Setting JSMIN to '$JSMIN' to enable JavaScript minifying])
> +   GIT_CONF_APPEND_LINE(JSMIN=$enableval);
> + ])
> +
> + # Define option to enable CSS minification
> +AC_ARG_ENABLE([cssmin],
> + [AS_HELP_STRING([--enable-cssmin=ARG],
> +   [ARG is the value to pass to make to enable CSS minification.])],
> + [
> +   CSSMIN=$enableval;
> +   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minifying])
> +   GIT_CONF_APPEND_LINE(CSSMIN=$enableval);
> + ])
> +
>  ## Site configuration (override autodetection)
>  ## --with-PACKAGE[=ARG] and --without-PACKAGE
>  AC_MSG_NOTICE([CHECKS for site configuration])
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 6a65f25..d4941a9 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -391,18 +391,20 @@ EOFGITWEB
>  gitweb_css () {
>  	cat > "$1" <<\EOFGITWEB
>  @@GITWEB_CSS@@
> +
>  EOFGITWEB
>  }
>  
>  gitweb_js () {
>  	cat > "$1" <<\EOFGITWEB
>  @@GITWEB_JS@@
> +
>  EOFGITWEB
>  }
>  
>  gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
> -gitweb_css "$GIT_DIR/gitweb/gitweb.css"
> -gitweb_js  "$GIT_DIR/gitweb/gitweb.js"
> +gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
> +gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
>  
>  case "$httpd" in
>  *lighttpd*)
> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index b76a0cf..01ee62c 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -2,11 +2,11 @@ GIT web Interface (gitweb) Installation
>  =======================================
>  
>  First you have to generate gitweb.cgi from gitweb.perl using
> -"make gitweb/gitweb.cgi", then copy appropriate files (gitweb.cgi,
> -gitweb.css, git-logo.png and git-favicon.png) to their destination.
> +"make gitweb", then copy appropriate files (gitweb.cgi, gitweb.js,
> +gitweb.css, git-logo.png and git-favicon.png) to to their destination.
>  For example if git was (or is) installed with /usr prefix, you can do
>  
> -	$ make prefix=/usr gitweb/gitweb.cgi  ;# as yourself
> +	$ make prefix=/usr gitweb             ;# as yourself
>  	# cp gitweb/git* /var/www/cgi-bin/    ;# as root
>  
>  Alternatively you can use autoconf generated ./configure script to
> @@ -15,7 +15,7 @@ instead
>  
>  	$ make configure                     ;# as yourself
>  	$ ./configure --prefix=/usr          ;# as yourself
> -	$ make gitweb/gitweb.cgi             ;# as yourself
> +	$ make gitweb                        ;# as yourself
>  	# cp gitweb/git* /var/www/cgi-bin/   ;# as root
>  
>  The above example assumes that your web server is configured to run
> @@ -61,10 +61,21 @@ file for gitweb (in gitweb/README).
>    projectroot linking to projectname/.git (but it is just
>    a suggestion).
>  
> -- You can control where gitweb tries to find its main CSS style file,
> -  its favicon and logo with the GITWEB_CSS, GITWEB_FAVICON and GITWEB_LOGO
> -  build configuration variables. By default gitweb tries to find them
> -  in the same directory as gitweb.cgi script.
> +- You can control where gitweb tries to find its main JavaScript file,
> +  CSS file, favicon and logo with the GITWEB_JS, GITWEB_CSS,
> +  GITWEB_FAVICON and GITWEB_LOGO build configuration variables. By default
> +  gitweb tries to find them in the same directory as gitweb.cgi script.
> +
> +- You can generate a minified version of gitweb.js and at build
> +  time by setting the JSMIN variable to the full path of a JavaScript
> +  minifier or using the --enable-jsmin=/PATH/TO/MINIFIER configure script
> +  flag. NOTE: substitue gitweb.min.js for gitweb.js in the INSTALL
> +  instructions if you choose to use this option.
> +
> +- A minified version of gitweb.css can also be generated by use of the
> +  CSSMIN variable or the --enable-cssmin=/PATH/TO/MINIFIER configure
> +  script flag. NOTE: substitute gitweb.min.css for gitweb.css in the
> +  INSTALL instructions if you choose to use this option.
>  
>  Build example
>  ~~~~~~~~~~~~~
> @@ -74,13 +85,14 @@ Build example
>    we want to display are under /home/local/scm, you can do
>  
>  	make GITWEB_PROJECTROOT="/home/local/scm" \
> +             GITWEB_JS="/gitweb/gitweb.js" \
>  	     GITWEB_CSS="/gitweb/gitweb.css" \
>  	     GITWEB_LOGO="/gitweb/git-logo.png" \
>  	     GITWEB_FAVICON="/gitweb/git-favicon.png" \
>  	     bindir=/usr/local/bin \
>  	     gitweb/gitweb.cgi
>  
> -	cp -fv ~/git/gitweb/gitweb.{cgi,css} \
> +	cp -fv ~/git/gitweb/gitweb.{.js,cgi,css} \
>  	       ~/git/gitweb/git-{favicon,logo}.png \
>  	     /var/www/cgi-bin/gitweb/
>  
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> index c9eb1ee..b6f379a 100644
> --- a/gitweb/Makefile
> +++ b/gitweb/Makefile
> @@ -6,14 +6,14 @@ all::
>  # Define JSMIN to point to JavaScript minifier that functions as
>  # a filter to have gitweb.js minified.
>  #
> +# Define CSSMIN to point to a CSS minifier that performs the same
> +# function as a JavaScript minifier, but for CSS files.
> +#
>  
>  prefix ?= $(HOME)
>  bindir ?= $(prefix)/bin
>  RM ?= rm -f
>  
> -# JavaScript minifier invocation that can function as filter
> -JSMIN ?=
> -
>  # default configuration for gitweb
>  GITWEB_CONFIG = gitweb_config.perl
>  GITWEB_CONFIG_SYSTEM = /etc/gitweb.conf
> @@ -29,11 +29,7 @@ GITWEB_HOMETEXT = indextext.html
>  GITWEB_CSS = gitweb.css
>  GITWEB_LOGO = git-logo.png
>  GITWEB_FAVICON = git-favicon.png
> -ifdef JSMIN
> -GITWEB_JS = gitweb.min.js
> -else
>  GITWEB_JS = gitweb.js
> -endif
>  GITWEB_SITE_HEADER =
>  GITWEB_SITE_FOOTER =
>  
> @@ -84,15 +80,17 @@ endif
>  
>  all:: gitweb.cgi
>  
> +FILES=gitweb.cgi gitweb.min*
> +
>  ifdef JSMIN
> -FILES=gitweb.cgi gitweb.min.js
> -gitweb.cgi: gitweb.perl gitweb.min.js
> -else # !JSMIN
> -FILES=gitweb.cgi
> -gitweb.cgi: gitweb.perl
> -endif # JSMIN
> +GITWEB_JS = gitweb.min.js
> +endif
> +
> +ifdef CSSMIN
> +GITWEB_CSS = gitweb.min.css
> +endif
>  
> -gitweb.cgi:
> +gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>  	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
> @@ -123,6 +121,11 @@ gitweb.min.js: gitweb.js
>  	$(QUIET_GEN)$(JSMIN) <$< >$@
>  endif # JSMIN
>  
> +ifdef CSSMIN
> +gitweb.min.css: gitweb.css
> +	$(QUIET_GEN)$(CSSMIN) <$< >$@
> +endif
> +
>  clean:
>  	$(RM) $(FILES)
>  
> diff --git a/gitweb/README b/gitweb/README
> index ad6a04c..0efa770 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -80,7 +80,8 @@ You can specify the following configuration variables when building GIT:
>     Points to the location where you put gitweb.css on your web server
>     (or to be more generic, the URI of gitweb stylesheet).  Relative to the
>     base URI of gitweb.  Note that you can setup multiple stylesheets from
> -   the gitweb config file.  [Default: gitweb.css]
> +   the gitweb config file.  [Default: gitweb.css (or gitweb.min.css if
> +   the CSSMIN build variable is defined / CSS minifier is used)]
>   * GITWEB_LOGO
>     Points to the location where you put git-logo.png on your web server
>     (or to be more generic URI of logo, 72x27 size, displayed in top right
