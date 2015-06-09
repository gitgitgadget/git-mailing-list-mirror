From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Tue, 09 Jun 2015 09:01:57 +0200
Message-ID: <vpqbngpl5zu.fsf@anie.imag.fr>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2DXz-0005g6-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 09:02:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbFIHCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 03:02:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38286 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbbFIHCB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 03:02:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5971urg000461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Jun 2015 09:01:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5971vA3017960;
	Tue, 9 Jun 2015 09:01:57 +0200
In-Reply-To: <1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Mon, 8 Jun 2015 22:22:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 09 Jun 2015 09:01:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5971urg000461
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434438117.25678@XEcC27uPjEUnZthgQYLy3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271148>

> Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms

s/add/addition/

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> +static const char *name_bad;
> +static const char *name_good;

Same remark as PATCH 2.

>  	} else if (starts_with(refname, "good-")) {

Did you forget this one?

> -
> -		fprintf(stderr, "The merge base %s is bad.\n"
> -			"This means the bug has been fixed "
> -			"between %s and [%s].\n",
> -			bad_hex, bad_hex, good_hex);
> -
> +		if (!strcmp(name_bad, "bad")) {
> +			fprintf(stderr, "The merge base %s is bad.\n"
> +				"This means the bug has been fixed "
> +				"between %s and [%s].\n",
> +				bad_hex, bad_hex, good_hex);
> +		}

You need an "else" here. Maybe it comes later, but as a reviewer, I want
to check that you did not forget it now (because I don't trust myself to
remember that it must be added later).

> @@ -890,6 +894,31 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>  }
>  
>  /*
> + * The terms used for this bisect session are stocked in
> + * BISECT_TERMS: it can be bad/good or new/old.
> + * We read them and stock them to adapt the messages

s/stock/store/ (two instances)

> + * accordingly. Default is bad/good.
> + */
> +void read_bisect_terms(void)
> +{
> +	struct strbuf str = STRBUF_INIT;
> +	const char *filename = git_path("BISECT_TERMS");
> +	FILE *fp = fopen(filename, "r");
> +
> +	if (!fp) {

I think you would want to error out if errno is not ENOENT.

> +		name_bad = "bad";
> +		name_good = "good";
> +	} else {
> +		strbuf_getline(&str, fp, '\n');
> +		name_bad = strbuf_detach(&str, NULL);
> +		strbuf_getline(&str, fp, '\n');
> +		name_good = strbuf_detach(&str, NULL);
> +	}

I would have kept just

	name_bad = "bad";
	name_good = "good";

in this patch, and introduce BISECT_TERMS in a separate one.

> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -77,6 +77,7 @@ bisect_start() {
>  	orig_args=$(git rev-parse --sq-quote "$@")
>  	bad_seen=0
>  	eval=''
> +	start_bad_good=0
>  	if test "z$(git rev-parse --is-bare-repository)" != zfalse
>  	then
>  		mode=--no-checkout
> @@ -101,6 +102,9 @@ bisect_start() {
>  				die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
>  				break
>  			}
> +
> +			start_bad_good=1
> +

Why do you need this variable? It seems to me that you are hardcoding
once more that terms can be either "good/bad" or "old/new", which you
tried to eliminate from the previous round.

> +	if test $start_bad_good -eq 1 -a ! -s "$GIT_DIR/BISECT_TERMS"

Avoid test -a (not strictly POSIX, and sometimes ambiguous). Use

test ... && test ...

instead.

> +	then
> +		echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" &&
> +		echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS"
> +	fi &&

Why not do this unconditionnally? Whether terms are good/bad or old/new,
you can write them to BISECT_TERMS.

> -			gettextln "You need to give me at least one good and one bad revision.
> -(You can use \"git bisect bad\" and \"git bisect good\" for that.)" >&2
> +			gettextln "You need to give me at least one $(bisect_voc bad) and one $(bisect_voc good) revision.
> +(You can use \"git bisect $(bisect_voc bad)\" and \"git bisect $(bisect_voc good)\" for that.)" >&2

I suspect you broke the i18n here too.

> +get_terms () {
> +	if test -s "$GIT_DIR/BISECT_TERMS"
> +	then
> +		NAME_BAD="$(sed -n 1p "$GIT_DIR/BISECT_TERMS")"
> +		NAME_GOOD="$(sed -n 2p "$GIT_DIR/BISECT_TERMS")"
> +	fi
> +}
> +
> +check_and_set_terms () {
> +	cmd="$1"
> +	case "$cmd" in
> +	bad|good)
> +		if test -s "$GIT_DIR/BISECT_TERMS" -a "$cmd" != "$NAME_BAD" -a "$cmd" != "$NAME_GOOD"
> +		then
> +			die "$(eval_gettext "Invalid command : you're currently in a \$NAME_BAD/\$NAME_GOOD bisect.")"

No space before :

> +		fi
> +		case "$cmd" in
> +		bad|good)
> +			if test ! -s "$GIT_DIR/BISECT_TERMS"
> +			then
> +				echo "bad" >"$GIT_DIR/BISECT_TERMS" &&
> +				echo "good" >>"$GIT_DIR/BISECT_TERMS"
> +			fi
> +			NAME_BAD="bad"
> +			NAME_GOOD="good" ;;
> +		esac ;;
> +	esac
> +}
> +
> +bisect_voc () {
> +	case "$1" in
> +	bad) echo "bad" ;;
> +	good) echo "good" ;;
> +	esac
> +}

It's weird to have these hardcoded "bad"/"good" when you already have
BISECT_TERMS in the same patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
